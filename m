Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437FCEF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 02:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjLc-0006D4-LE; Thu, 12 Feb 2026 21:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLa-0006CQ-LV
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:55:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLX-0005Dt-AY
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:55:57 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CIRHvA1084929
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=tGSXO1Hxr87
 iAYOfKjbhXDBVnAD/nuMU+cly4xtRXOE=; b=o10I0l+egZuSG1SuPAFUoSPUNR/
 JJld4/yfdGXFohgQBIIRwrXzJ/hnO7kVeTrc7nvJFlva3Kvs+ldX87Snv7rC8EWE
 IV457JcsF/RmUX/V1ybz1LEvWNp/USbQGwhmim2QusonuEi2tfKHbWwewcMuPH7q
 Lu/oxSl5EXlXhv66mjO4MMhDG1X6aST0wu1+rF8bimqrek1afXvOA6paV8bDCVES
 QpvDCElNHuOTljTe1VSbbzKZg9+iTffi6XNsED+/fm4ArGdUpi87TsU24vDczZJ8
 c+AQhOuieHrE3jeJhp8BkwLssKHk61airIbi8dquHl6Op+a3XAxG4W9jK5w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cy4b6qs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba73b692b8so263404eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 18:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770951351; x=1771556151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tGSXO1Hxr87iAYOfKjbhXDBVnAD/nuMU+cly4xtRXOE=;
 b=RaaI/SSWq0QdSX9ksvbemWgp6GfBUM8q5F/V3f0SvgXjpismoNk3doPOV3Eszh1BoG
 jXn9xKWIHwdfoGAm7JPXxA+G10Hrf6eavy3QBNo9tCx57zo7Ois3nBaE3r74IoHY5rGE
 P/GwJOv695//MoGqhOk6hSgoanwOyhWjK4csmY5qi1Hhh1m0HlIog3Q0WPMzX1UadqvW
 ebOy8GCuTje4wWB/68EppVGWfauLs1S6D40wZDxKWxK3ZlsAb8/t1UvzK1JuWmxV9k/C
 4EjUHvHIGceqxF5kevYXSjuxbeq/+G4c4FW+KI+xh1ZDi+huu4j+Eb0HPGFaRibR+vQD
 ZB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770951351; x=1771556151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGSXO1Hxr87iAYOfKjbhXDBVnAD/nuMU+cly4xtRXOE=;
 b=GXT+75zm52WChc6vYTcNcjZICbzEzMyrVz3sNkEYMXn4vpqklu5kNeV7Q7HgckFgAD
 X2lK6RkV9G8Ov6lJ7Lwqi3ImGS8q0xYzf+wqi78VAwkS39YYCxfkJVFgUHLSLBzeSTL7
 dlwj8nh6O/DKS3Zk34exQt1J2QVvojueu3CIu8FdPQvtPJBlIhGKV2XpxQ2n+gTDdpnZ
 oRPZBKMGuLlu2cCzPeo9zzLmuoEU/1fgYX1aIlFO/XbxERn3P1bjdhIqg3xbBv37nj/n
 FxcAPXoJ3BBFCPexo2vipUQHjrf8P9ZMsP0q46PrBryFibmBFoIWbFC9nTanHFRpwQ90
 50qw==
X-Gm-Message-State: AOJu0YzBcPWZ8yO7SBgi1URNIwurP9a2fuNlFnVofDk/Y4DibTwqYtRm
 4ZinXa1whzSxHf43qAQZPJ7+/+i/XGAZwBBazgVHyftHZG3XsFyaMmwj9y5MHWq0tpZ2U7Vbxeg
 08PMzij/5TIqE8RAtfF/2Xhazk2dz/AQRxjNuYa8mydkrtZzqcY3tHo+jXFj4UU1H5w==
X-Gm-Gg: AZuq6aJRjk9MgdFaMA5XF+lXelhR3e6mkeEBDK5Ptp6GkUCcj6TrRmLrKOEiUH0JmRG
 WwI+2pICWUglFy4b3dCdzSntk6TOFvlAREZQFqoezbEo8DGtBxXVxMxcOju2T2kxeIquRgcDQmw
 qovstJg5JOPNZfzcRCRA97ZDEanrf9HCkcOrxduSC3Kb5KksWH6MEVtMAqV25RIwyoJ3mWmRSbO
 AYRTmqSjSUHlZpEb3S93YgxXl1UAVfvYJKOVorIsYpsKCx/nzhcPbimem3YOjCpcreFEb28ZFD2
 1e/5fIkwWdJ/GnM2Kt+PfCPg+Bv2cU5GxsBzvCFouodp7Sd0oZ946NDgjlcdd/5wPwHIP7ZF6lF
 WlLBuoXhIKJ+JeW6MQMvOZVJATrY3Tu/9Vweot1d4giMcMJshGBgWTUHnjxahFtfS+OvmPw==
X-Received: by 2002:a05:7300:8c03:b0:2b6:f13c:8d58 with SMTP id
 5a478bee46e88-2babc151139mr176565eec.20.1770951350872; 
 Thu, 12 Feb 2026 18:55:50 -0800 (PST)
X-Received: by 2002:a05:7300:8c03:b0:2b6:f13c:8d58 with SMTP id
 5a478bee46e88-2babc151139mr176551eec.20.1770951350289; 
 Thu, 12 Feb 2026 18:55:50 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbd5d3esm4500943eec.10.2026.02.12.18.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 18:55:49 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com
Subject: [PULL 0/7] hex queue
Date: Thu, 12 Feb 2026 18:55:37 -0800
Message-Id: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: SIJ1Nrf0MEQZKyuDwu7CSAK32vHJFegM
X-Proofpoint-GUID: SIJ1Nrf0MEQZKyuDwu7CSAK32vHJFegM
X-Authority-Analysis: v=2.4 cv=XvX3+FF9 c=1 sm=1 tr=0 ts=698e92b8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=5cyGM-j2jLZPnQgDAAYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyMSBTYWx0ZWRfXx8WqWrDf+Xjq
 6arW7ZI4hBMC2xrINYjXSTuIrgJcMeuDqSlqMURXT1JvzY6qr3SA6CY9vSBeyohVhyPH2PiMMZw
 30JdMT44lBUnqLP/fleNn5fcW4aphZMzaKHK8pqurpHvkBvCijcZ18C5LEtOYOp4IQaiT+LXhtr
 nG2prIBDV3rfJCKM2qj6QLGLMLJijJ8YaCdbmrB5DR7OykWIH5wL1t8hKCt3iLPa0TNIFoAlpek
 e2PbLQl+1HJy11/eZPkiq3KDoIm4+HyR+Gsr5+AK/lFV71aD4RqL2U+4hMl/niNJnm8kCIk9cZg
 W5bFoUjeMd/EjpT/ldutu2uCxQxVtwRzk2f+nLvs3G4vXysj6qSg0/dJWG7udDTdbDzAkt9jtNK
 wOo4zSvhgxHMayrljN8cOD9iZCueJOZ4tT9B4s2XnOxLLavc9JrctMxDl34s5ugpml7Lh7XlBFH
 jhkUeNAp9tXF+9kROeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA0ZWQ2YTdmMmZkYzA5ZDlmYzM0MTFl
ODNlMjc4ZGEwMDg1MTIyMDE2OgoKICBNZXJnZSB0YWcgJ3B1bGwtYmxvY2stam9icy0yMDI2LTAy
LTEyJyBvZiBodHRwczovL2dpdGxhYi5jb20vdnNlbWVudHNvdi9xZW11IGludG8gc3RhZ2luZyAo
MjAyNi0wMi0xMiAxNDozNToxOCArMDAwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBv
c2l0b3J5IGF0OgoKICBodHRwczovL2dpdGh1Yi5jb20vcXVpYy9xZW11IHRhZ3MvcHVsbC1oZXgt
MjAyNjAyMTIKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAyN2U0MTU5NjNhMDkyOGQ1
ZWUyMTExM2U2OTY3NWE2ZmM4YjkyMjVmOgoKICB0YXJnZXQvaGV4YWdvbjogUmVtb3ZlIHVudXNl
ZCBpc19maW5pdGUoKSAoMjAyNi0wMi0xMiAxODozOTo1MSAtMDgwMCkKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRml4IGhv
dyBxZW11LWhleGFnb24gaGFuZGxlcyBpbnZhbGlkIGVuY29kaW5nczsgY2xlYW51cAoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpBbnRvbiBKb2hhbnNzb24gKDEpOgogICAgICB0YXJnZXQvaGV4YWdvbjogV2lkZW4gTWVtTG9n
Ojp3aWR0aCB0byAzMiBiaXRzCgpCcmlhbiBDYWluICg0KToKICAgICAgdGFyZ2V0L2hleGFnb246
IEZpeCBpbnZhbGlkIGR1cGxleCBkZWNvZGluZwogICAgICB0YXJnZXQvaGV4YWdvbjogUmV0dXJu
IGRlY29kZSBmYWlsdXJlIGZvciBpbnZhbGlkIG5vbi1kdXBsZXggZW5jb2RpbmdzCiAgICAgIHRl
c3RzL3RjZy9oZXhhZ29uOiBIYW5kbGUgU0lHSUxMIGludGVybmFsbHkgaW4gaW52YWxpZC1zbG90
cyB0ZXN0CiAgICAgIHRhcmdldC9oZXhhZ29uOiBEZXRlY3QgcmVnaXN0ZXIgd3JpdGUgY29uZmxp
Y3RzCgpNYXJjbyBMaWViZWwgKDIpOgogICAgICB0YXJnZXQvaGV4YWdvbjogUmVtb3ZlIHVudXNl
ZCBFWFRfSURYIGVudW0KICAgICAgdGFyZ2V0L2hleGFnb246IFJlbW92ZSB1bnVzZWQgaXNfZmlu
aXRlKCkKCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIHRh
cmdldC9oZXhhZ29uL2NwdV9iaXRzLmggICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdv
bi9mbWFfZW11LmggICAgICAgICAgICAgfCAgIDUgLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5o
ICAgICAgICAgICAgICB8ICAgMiArLQogdGFyZ2V0L2hleGFnb24vaW5zbi5oICAgICAgICAgICAg
ICAgIHwgICA0ICsKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5oICAgICAgICAgICB8ICAgNCAr
LQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgIHwgICAyICstCiBsaW51eC11
c2VyL2hleGFnb24vY3B1X2xvb3AuYyAgICAgICAgfCAgIDUgKysKIHRhcmdldC9oZXhhZ29uL2Rl
Y29kZS5jICAgICAgICAgICAgICB8ICA3OCArKysrKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYyAgICAgICAgICAgICAgfCAgIDYgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jICAgICAgICAgICB8ICAgOCArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAg
ICAgIHwgIDMyICsrKysrLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYyB8
IDEwNiArKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLXNs
b3RzLmMgICAgfCAgNzYgKysrKysrKysrKysrLS0tLQogdGVzdHMvdGNnL2hleGFnb24vbXVsdGlw
bGUtd3JpdGVzLmMgIHwgMTY5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkgICAgfCAgMTAgKysrCiB0ZXN0cy90Y2cv
aGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgICAgfCAgIDggKy0KIDE3IGZpbGVzIGNoYW5nZWQsIDQ2
MSBpbnNlcnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYwo=

