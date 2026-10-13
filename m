Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615C9CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkPe-0006hF-Nv; Tue, 13 Oct 2026 17:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkPc-0006gn-OP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:51:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkPb-00055O-DZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:51:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHQXQ91592131
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QEEPY2CnEdO+OgrBs6TIaFp/MGsXy1WWw5TiVDJLIPQ=; b=NVA9ZZMRNvIMA54A
 SIri74i23xMOKeisP5xUxKAikYNpQ7fZ8eJWRJ+Ionb4yyqIU5UDFTlJKTKjRXqy
 J/ZiGiYS31W3aiP0lo1ZDwDPbod2wTN1JiBmfiH1qmRh3qaW2I2gPxwMa+a5QDqs
 Ns1hrK/oy8ePIhs6RW7K34ic112DOFfGQXFZ/9dkxh3wHAC3y/JjdhQJJljRrHiz
 oGuGvAkg7Pgx1dnklwbPgmA/oHXQPkcQ3CfmlzNuamZm2OCFpRyqeYulSqav5tce
 sY8G3Yq297DXaME0o+2TmiQUA7HtykWBS3jsUA/ZR3LYYMI87YSj6qeJcjELOxN9
 YeQaUg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1th3cd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:51:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3580c07911eso8888452eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791928309; x=1792533109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QEEPY2CnEdO+OgrBs6TIaFp/MGsXy1WWw5TiVDJLIPQ=;
 b=XzQTAOHfp92j81VRQ+pqTYPifjBZBNTCCqJ4MtinQBzkgIPob2X1cNx7Pa4t4Le8sH
 mKQJ14/D1BQQ8keR8XWZKGDOI9RsoPMX8hXud88hVaKbTXJZbJsMeS103N79AMc++z4W
 dRJ2Fy5gq6iZ/jMaxg/uKWhacWNGZdCehSTIgu3oq+jIr0EIeIdRXhwaUOf7tgLPBYf5
 8PkWnkH7rhLwxkVSzCQtv0nLNMD/qVawNlDyQzwE/gTsnDx/varq/NjR2NhAKn1sqWUN
 O7jINgzzOuvZmlPC0TGQo/bWnM9zJR8s+/Gh/kkgsx2JuJDehP+RPhumu1Kar/0TiErI
 oPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928309; x=1792533109;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QEEPY2CnEdO+OgrBs6TIaFp/MGsXy1WWw5TiVDJLIPQ=;
 b=xFgAQSJoK7guS56d0YcoY5bqEvp9FYL/mc0NZHvzG83OfxYfYnSWYqgcmaQc3biPkL
 01tRZfgrSuafnvtmp6wtOq6FuXjFBoeq0FQKlKmiGp72ORQcuP+K3uoKZ3GuAQJoLdsh
 EXnxYSkMGJlTxYnpC45FbxdZgerNMVMcukgzGV4vWpXbQtYDLD48/vomlX2kkf1NNUOn
 8QhI9hcwIqg0RecSAvuvFqSjLVffiMUyU7KD9r3qD6XD0zklHnqAGXt7a3T78jGqNXzg
 /RO04eVhQu+ojwatZIRrzhzUDvMmwxPJzmyTkSgXthxo53L8bF2Lejv9HHMcUkMsQMKK
 8S4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpGUnErUKYMW+psAx7PwZSdH/Kmq84OXHsjRwH21wtmtL4Dx5VOwyQgJ4NhdMoOp6t7aB/R04DR5IF@nongnu.org
X-Gm-Message-State: AFq9FYKjZOuVwVoEaqAfLlGkDrO0Ui4oaNRdDYx49nxT3NyscranJm1d
 ef7Oc8Gjd0K0ecbTR5x3kPCeUWu7Pry9j/2NwdzKdWFXC3Rw7mA2tDZoN9/J7+PQfe9tg1ID/9/
 fqfZJfwmX0ToLqGp1z43bHzGnx9CZw7ulqYtgrYPhpEc1eNC9Sqsg+jsPLQ==
X-Gm-Gg: AYBFou1BFTI5zihzioIvTOQFsCF+/lAWMo4hgHmco4GuCIc8rJSfDL6V1eWqENAqsrd
 tgH0v8ig3/uSvL9sjmMz18k8DKbArN0B116i6mzdlp7a8X59wS471q4TdLu6vIN3fppiknYD/40
 LHjT5OJPF6l2l0EDw9D0hPPpAF37ZoBqm1OWb1tsMlh7vw85sXK5VaxduB7pfmulZmfqRt3BWh4
 w5MCmJ0LU9YltokCjithB4wJ35ckBFUV2LicBH96bJ9/EQGRo1PJVyfbD7qi6vipNEobH9xqR0J
 oTgAt5ypveZZfQWkYulT10aWr6DXZR7esPeW30Wrj+F6UQoV4cGZ4F7dihE4806zzUiHNx2QqeQ
 nMdZn9OcuzB23ZG5jRIIVRdjt6f3S0tekVNbbwWUd/z76Wnk5MqzP6Zb4ehtu8BnEu5yR1g==
X-Received: by 2002:a05:7300:e5c2:b0:358:2e30:8e5 with SMTP id
 5a478bee46e88-3582e300988mr16400016eec.1.1791928308810; 
 Tue, 13 Oct 2026 14:51:48 -0700 (PDT)
X-Received: by 2002:a05:7300:e5c2:b0:358:2e30:8e5 with SMTP id
 5a478bee46e88-3582e300988mr16399984eec.1.1791928308113; 
 Tue, 13 Oct 2026 14:51:48 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm60965365eec.9.2026.10.13.14.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:51:47 -0700 (PDT)
Message-ID: <7e3543fd-b10f-40c1-934b-f89db131c9cb@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/hexagon: wake K0 and TLB lock waiters
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009192541.4163758-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6acea7f6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=s6Lvd5_Ut3sivrC6h3AA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX9GUADGAJssg+
 IjmhV/3yt+j2OAEq1+6JAj5AvZTtQlz4HTBKKQ1bTMwRKb88qJ0oaIewLCEG8NA/BQUjIVh+2Ff
 0fkVmDkTEpfeToOy1e/Qjp/uv45/W7UYpIYskCYl3TwIXFVtro1az09s203O1e5ke920tsraEPM
 2ln6J/8K3xXr1pKsdSmQJP3PXnQ0p2WDgyI2t+KxNbQuPCStfP142c0Iyn4JcG+kQWyIb1kY2rb
 v90L0wkOEWCN3eWPDJu3XErnrdQyLplBP0vmvz7u5LXCDrtOKMaSIuvDFZZqL6R8+jzK9a0ozsh
 FtyGiDw1nEMAuolJSpUUWOXd0atBczrjeLnhOVqLWUTV4J/HZoayydrGiUqVcWx9UXYwLW0r5zI
 DEVQjeR2BoX0tHhs5O5Zi19wfckv5Cx8hJqe67xAHSES5ylGNAYhugYilzfCusEDg9Hnw+22wKT
 W1B4cAI6v7yeD3z1S3w==
X-Proofpoint-ORIG-GUID: tAfL4ZozvfnXaej-jMubOE1pOD9XGdmd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX+ygO7LzXId/j
 3RRlaXS0zNg/rg/UN4FA/D0P6AApuOr9k9QbIzhPb+ANx8vWTqgurKHUbDZNfblkY3HuyDkVLBL
 68LgqQlguHfEbblk3WK4M8wXa8Q/NPQ=
X-Proofpoint-GUID: tAfL4ZozvfnXaej-jMubOE1pOD9XGdmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/9/2026 12:25 PM, Brian Cain wrote:
> Wake the selected K0 or TLB lock waiter when ownership passes. Update its
> interrupt state and kick the vCPU.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.c     | 2 ++
>  target/hexagon/hex_interrupts.c | 8 ++++++--
>  target/hexagon/hex_mmu.c        | 3 +++
>  target/hexagon/op_helper.c      | 2 ++
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

