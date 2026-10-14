Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8110CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2ck-0006ZW-Pz; Wed, 14 Oct 2026 13:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2cj-0006ZN-8i
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:18:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2ch-00048o-6J
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:18:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4D694167044
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5jn8YLLvjQHBwVIkODPoTFK374T9LjZ+kZ/hPZRGN9Y=; b=Mv/ceSR2F4032OyQ
 l6as/W1nAm6aOqX5r082iBTcH3An3nqr/YYsnPOevDM/V+J8z1VyFNKhrbk7CZE7
 w+2IgB9UiBpKCqCQJ97B71UChpIaI5Ez5GWUY6/N9ybsq/ZayPpnV2OHs2A70r2A
 HwtRd6oJY3nWepS2lW9B4GRKxuVDkJ8Rjwxvbl+7MvgmA9WEFRXXrQcOKoK2C8yg
 5Le+RexU/Zblh606XRv+RcHATPrmWzDhxsXyivyzKvDF3JVIvEdsdiXZlv8fQg8m
 TkQoPbAD/24DxfIQkzXwN6POpTDPkTnNErEU5MtLTfQ6GnJF1bve0voGK9CIehcM
 /GgGow==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac230hnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:18:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso8167704eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791998316; x=1792603116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5jn8YLLvjQHBwVIkODPoTFK374T9LjZ+kZ/hPZRGN9Y=;
 b=AbZ7XfjDJrf+I35t80/umMMRWv3dAmR/aFjrPW1zCpc5krIO0ssFwgc7gsulYeJS2q
 +wAg68N9NLjsFN8K1BzJl/xbJZR9a5PBnvxa2CPr4CXeE6KfJNODz+ghGuJyjLnaw/Jn
 gQgC0A8ZLeC2U12xpOlLlNaVgd/52fspLRJKUqTFlfqjP7t+4pQL0KEYlcNmDKoXQDuH
 7NSFSeGRMwxAgitU15UkapHOWx9JomIi/eVYWDO3a20ADLslKt/1GQ1NUl13YISitRCt
 kL6GioZO41grZVsA2x0jy4wHRet178HmfhSX3SG2D0ng/s8qCzjXlQBIsHk0aL6pKqfB
 /QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998316; x=1792603116;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5jn8YLLvjQHBwVIkODPoTFK374T9LjZ+kZ/hPZRGN9Y=;
 b=zHym+FXMIO12O97LSiaPL+upnhceuJXP2A4Vm3NiRdr27V9rexjhOJxZ6TOBkzu/8p
 a+2QoC9ph/LcWzvqA1x/R7aNI8pwz90VOAWgLc5/4wMnaPP4muw+KzTGhEZmbsdRbZ8m
 xcW1l9LeAFsjCxy2Jlrcd1Z7G6HePQt+7BuQ4HqRnXbnk22/5gwngE3V+rEtHl7+/BAM
 4PrBjUO+mtNfZwSYbcSd29KZTQSawNDJaKJObjpKtfoUWG7zT1qNwk9dDJlef0PhxEuT
 X7zJ8pzyzSm1zVR0Y5PHtWvEA6Fdz4JyLJkTZgSjaZr3yei6n1XvmkXyNZNPD+hyTwhY
 Gnqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBypuC/w/tlmd6w8AkIOEtYgrWOuJK6wSv9C+LvOXRaltyX0eOGtFrZTTjZVC9QRAn2b24T5e2TpnD5w@nongnu.org
X-Gm-Message-State: AFq9FYJ7v4s+zFTBnJ090wkorTNRz3SUh0Cqfcny2cpD4u1P16fpkD9d
 jnf+UZD6oexbQEXrIw/Lj84eKsp4CVtHse5IGS5upASrrEXEpSprA7fCAj3Yc5q1hqRWLfhJMaw
 gbXHtBE6KXJfgKAPiJMu9PD7Z8J6uoWmUvP9Y+52mrRhtNn3hbONdEgf9hA==
X-Gm-Gg: AYBFou1BO9bclH6y1L8v5U/ImfQWANGhIIVLt7fOFNgmU87e64nIztqIRw6g0H6Kmhq
 Rl5YhE6ij17v2tuSoOZCqnaznsxjlkO0uRoWGaAC5pLJ1FRhA7D45oWiX3S7+8+gpxEzk5WcVdx
 saMIRrnZAFp8OgRn+Ce1hajaQ59b1r0e6Tsih0sroMWDuQWEf1nooaiV8RcMHJjKkvpgImiaan6
 TTpfLwTVUhCa770ZT+yJV2eA+EWtavgblbBzQSbtMx9Dy88Kb8/0HvuymKphQwHYndTGL2nXcvm
 o3IZ9pdBXDx3BwTRkbZ8BRXXLbpQyj0qGOptQRvw4bz5BqDL38hCWqjbmfKFHaKa2SyVG6bbrOR
 bMcu49g1lSZSpPmaiBgh6cVqRh2QHTWOUD4HsZKq8Dd2JvRPMBpgd/eZBwuWjEEfIiTTzow==
X-Received: by 2002:a05:7301:1a3:b0:35b:7dcd:dd57 with SMTP id
 5a478bee46e88-35b7ddd267emr10294986eec.10.1791998316339; 
 Wed, 14 Oct 2026 10:18:36 -0700 (PDT)
X-Received: by 2002:a05:7301:1a3:b0:35b:7dcd:dd57 with SMTP id
 5a478bee46e88-35b7ddd267emr10294949eec.10.1791998315666; 
 Wed, 14 Oct 2026 10:18:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm40642787eec.31.2026.10.14.10.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:18:35 -0700 (PDT)
Message-ID: <3d77b66b-e15e-4a9f-b263-fb37a2e0ac79@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:18:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: mark clock-backed register reads as
 I/O
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009003521.2227155-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfb96d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=eJ6PafDrsClt6_pTYm8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2OCBTYWx0ZWRfXwZAoJ5e5tyfy
 Ph6IVj9hj5I+ZCcO0SjIalI25Gy0p7WxAX8MqMpt8YbYDHgdtykh3mTIpRC1DbydsGKkbepw8Em
 NRjd/Q4ejO+0qGXW9mONKmJtl64lnFw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2OCBTYWx0ZWRfX9uH+aBAPyiWG
 SDhmXHKCjGfp2RsopQMq6SWU/2HzbJko0ZG3y+L4keP0ZCTw1doGs2hRpj9Nniv1KcbxebW6LA4
 Chaw7ETYzDUaP1JFwhMPdGhS3ac5esbnaf2SYZkMoMg7XdhpAx5oQQBDmO71AgEoYE/bxQpONFr
 ozgYsFhKboP62drgjpVpeDlEngS6CYDuy7l1xeTKHWh5gmGI10x2A8wU7qtRizzBmgGmlj1T9bg
 sf2keiHJZZ+eTsaHXq5myqSOS/CfBJdizbPYvqiLhlOOI9jTH/mpn/JnVISejRZTNYc/DYu4sz2
 WaB+DcRsWKooPTJxynLxhtlxuO/XAhsKfK00Yn0I4Q/+Rbkm2MzJot6kRo8diThM/R17lUPnR73
 oZE8T9lbSwks7pbFIvTYFF7uqpvCGv+rZ0zlz/QcSVQX1SmUf5IjExMT1j5l9yvnOjklqNDdfQH
 VSXowsjuUc/BtZvsv/Q==
X-Proofpoint-GUID: nSayoXW0QGZKRFgtUohZxc4Po-YovggN
X-Proofpoint-ORIG-GUID: nSayoXW0QGZKRFgtUohZxc4Po-YovggN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/8/2026 5:35 PM, Brian Cain wrote:
> Mark scalar and pair reads of *PCYCLE* regs as I/O so icount synchronizes
> before reading.
> 
> Cover the read paths of {U,G}{PCYCLE,TIMER}{LO,HI,} registers.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_sys.h | 12 ++++++++++--
>  target/hexagon/genptr.c      | 30 ++++++++++++++++++++++++++----
>  target/hexagon/hex_common.py |  8 ++++----
>  3 files changed, 40 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

