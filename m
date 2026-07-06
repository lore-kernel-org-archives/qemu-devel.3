Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56720C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfAR-0007kI-PZ; Mon, 06 Jul 2026 04:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfA6-0007hZ-6I
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:58:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfA2-0008ME-PR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:58:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6668jEHT3624558
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1/uqlUN1ub4XwzyuuWJTFRRxsZAcHXJ1jXD/sNb1VG0=; b=DCjSalQ58JxokhEm
 U6ZLiXahjrVuPYorsek6C+98NrkzbJfiqY9RpRzv8DLsvr0+kPnn6/v6FT5y8xyP
 3rbzbAagbPJvWGUx0iqyeP2FzpMeOwLPGJcnAJYMUFRd+kGWoBJgLrfJYBvdbc2x
 tqsnfgBrg6DJq463o6biAk0BzzGTsbJ2ks3m2U6UTh+80dFVkOl//Ialf/B2npIO
 ysFokguz8g3xOyIDywGNZD0trcv4qZefZyTY9MqMbWOLsuWwhxn1oUVwnuo//G0T
 YPoWA2CTvoECIhrN1tuLD0bwywTCF99CH8baeDoSLDkI6AY2AcvGqlDDC18QlhHc
 hnBRZg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4swhmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:58:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e820609d9so195892185a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783328319; x=1783933119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/uqlUN1ub4XwzyuuWJTFRRxsZAcHXJ1jXD/sNb1VG0=;
 b=Fo86IY+i8DWhTm/gZ+VEq+hsunuCklREGbL9AEcZknTy82/cM3BR1o4/DxHphvC8WI
 XEsFmd5WFZCD46f5q4GXg/ojjR778GcqRWuhpHIgwUAZZhfZKoynbrNdxsx5uYRldarp
 3B6kUsMgEqiTTfMn1zEHtJdPh3MSApBF5dQCZixzu/RfSR9B2cohRviLCVILOzrMcouv
 9hB3wARtr+3zXnfbOUFk1VbK5UD97xN1x/jhmvzEJirNFIQamoif7hm1I7i0cf6q1mUb
 RhjBGln7yZ8qKAnunG3JUshOnEsBa7mhngobxWx2wSGxxghTo9Pp8C+pDZgfA10OHpJI
 t7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328319; x=1783933119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/uqlUN1ub4XwzyuuWJTFRRxsZAcHXJ1jXD/sNb1VG0=;
 b=cyDdRnWP4rO+XMYqr9JhScA/a5ZJ7F6oSQqB4sEsyP6IOEXrUrUfNz6ipicC2IsPYT
 iTMMOhyVYl/EQPEdGm8ZUXi2o7Q/+yIto+uZvGTcp2Z8weIwWkLVE0QpEUrNo3COcJ6F
 Hv2EYMQWQ50s4K9R5Hg2F4CL2odolaPxRYJ2+5M7+Hg3AntjNi7Kjv3VM9YV/XR8ojKU
 z5qi1x12o+ZjgRFo7GTiEdBqjJ9jJiJcAA1CEvx4ISERUo4h4bVOdWNtaI3VUKBlJGUS
 buuuZtQ6jVHCGMIpTch64yEt0U4F3wgz3S/XiyKxS2f7Wj2TOZdNBtgnS+P7i4tGJcYp
 LZZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnKzh5SZfj9O9eWz0/FiaI0TjHwS87FEQwd94GGsbMSfRmPRlw+QeESjkkce4Eov3wN46PiKJkxna7@nongnu.org
X-Gm-Message-State: AOJu0YyT0x8BpLoeVugET/WdyKC3w+mCJdCx5JzWqNvmAI18qeyNunUp
 /Y7EeGnmjwlcxcf+eeTxopip6sk28WuFkB6t8m/NYdSfVkm8qrKdlPM+OQfdZPnXoUNqu/Mf+4i
 NZKOhA7+9GNozFm2nQcLR6z+CQvfA8EEXkBYVFCshD01kMV7h1RNw/gWpgQ==
X-Gm-Gg: AfdE7cnPZLQoxUA/MQk/LH+TSPQMM2MysUNzODVBU9fArMbxo9EEhjKHdOkcuA3cjl7
 f33DUEj5IJaEDaTcgmyRgHLGr+AIlnvP5AKwFTYXx0M/Qt4M1iGcG+GHlKwLfZ2S7lfh15v7BnU
 2bckbngzZ9mz84/I2S91xVkxN9l9HKu/1UWqnQfUCb/L6XQkxdMyNWQpUZaCTVCe5R6Q2Xa4ENU
 bumKx2lU5bwFDJ5VoNspm5Iu6cEJNJHnxrRv4s5HuLPn8vlfgSwvSSO3+m1mGQj8PR/WDUOHO2E
 utSQe/flQZjbP1LqgUjnTOzQja5EEEkQ6UlA58ctEViRUJ0RqFxCr6Y4JZiM+hIRKXnxazc/xVw
 PlRTkmKXbPA10ULTvcA31zm1bKqB5uP65g8JYheiwFpnqIq4pro7XdUY3clyRAA==
X-Received: by 2002:a05:620a:462b:b0:92e:4bc9:6ebc with SMTP id
 af79cd13be357-92e9a3e1c50mr1281645785a.28.1783328319460; 
 Mon, 06 Jul 2026 01:58:39 -0700 (PDT)
X-Received: by 2002:a05:620a:462b:b0:92e:4bc9:6ebc with SMTP id
 af79cd13be357-92e9a3e1c50mr1281644885a.28.1783328319061; 
 Mon, 06 Jul 2026 01:58:39 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b629a1d4sm683632366b.39.2026.07.06.01.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:58:38 -0700 (PDT)
Message-ID: <931f68f9-16c1-4057-8b7c-35ff27f8113a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ati-vga: Include vga state in the blit context
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
References: <20260619140408.6CF98596948@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260619140408.6CF98596948@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfX9TeS/5rvB1WU
 mY1bkXDsT3h13xlzB2/7DTWWZcPklNspvqjnHGqpJ5awyTIZsHS20XG6cqlJXRxESoWp+moumV0
 wIoWsa+XUxC7tCbMjVu+6Qh6AIkkup8=
X-Proofpoint-ORIG-GUID: Pqj6kKfCrHKmDExkBPuZyQDt8_h1IGZM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfXzEDf3ubxnqWL
 1m8+CSv0cRimE2XdpM1oJH/9PUlZwZiEa8BEK32oWtanIfZrXec4/fq7MjmZpEa0arPEzKAQPdz
 R/9L19kN3AQ1G/hIYWBRs/fDz6WbGt8uZnv+uOBLFWM799paSbPe38Wja/IeICfd2hl73rv0DLN
 XH3/9ogRwY8ORJEn+Jbq9t+ReE1J6a8WHTtN4H0AkdOIX4p8lozxAIwgrwDu5sRoHmDVo34CXrx
 uP8HhDidI33ilN9PhqmTRkkQMW3KSkhMa+L45Z6yFj+ZYL4WiLr0UZlWBltoBpShSf8xalkpH+p
 +LEwGzCk5hN6o7rFVq6vL2MGUIfKA8AM2JaXX6ZQUgT9DMBBOg9oSEbgz3qdRGioyIdKGbFytZm
 uogFtsKEudxmEjbvKld5POaCxDd5vni9rFrwPR420HJnowKUkMirdpfAnWcnuJzSFJoHR78nQJj
 i658vBFM6zc7AyU4/Lg==
X-Proofpoint-GUID: Pqj6kKfCrHKmDExkBPuZyQDt8_h1IGZM
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b6e40 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2f6ENiU84E2-asKVN40A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/6/26 16:04, BALATON Zoltan wrote:
> The vga state is needed by several functions using the blit context so
> just include it in the context instead of passing it separately.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/ati_2d.c | 38 ++++++++++++++++++--------------------
>   1 file changed, 18 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued.

