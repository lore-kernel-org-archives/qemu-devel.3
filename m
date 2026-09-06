Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37517C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 22:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3LJR-0006GJ-Ge; Sun, 06 Sep 2026 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJK-0006Eo-Ak
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJI-0003a5-Kt
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686LAgbg2006022
 for <qemu-devel@nongnu.org>; Sun, 6 Sep 2026 22:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yagXDdt/EXPs9+Fn5yPiZj+H0jEXPpISU9Tk/oZrPSA=; b=PfUG32nHPlU7JQca
 1V7pm37uco01Wjtcz/ewPnPk52qX48izipESsr+HqkjsBGjufnBtutn6rhz6pxVA
 CBmxnA4/S9pQd7FcI1CCDP/9YdEKWw4kjguj4MwT+lU3Gebd4g4xsEOivi0spQFw
 7V85VDiqllGIrBgNVD0/uY60OAeT2aQKwjxVsnBEW+i4QcLIpBLGdxo8Y8AcXNMS
 z5W5n09d5x8glPwH1RQ6uteYuz908bfXVPn8LK/votxrT4iMxP1lMt0DUgoBdohm
 8LzwKW0GlaTC0meJ5idKShkBqLOIZQxOxpoMncIVDBN27OVvtlWAVfvKSBMJyrPI
 102elg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggadhm8v5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 22:25:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc44d708055so5308652a12.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788733557; x=1789338357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yagXDdt/EXPs9+Fn5yPiZj+H0jEXPpISU9Tk/oZrPSA=;
 b=Or2yMG6sLZWCGG4zg30TJzi3kEyD7n69xTOs5uRMdctFJAfqcExbfbacQKgsvS2HIt
 ReHsgGbHM6IotQTg9WotkwG1iNET+LqBjlDGgp9clT4dfM+wHPMZCQEv5+CfpO7TN/j7
 qFzFZP8dghvy3tSNZar8Z9GrTS1GsWMtYi2zmj7zsPDAvdLeqlIn+gPig1gLOHpAoeVU
 kB/68Lwtg6TIc20lFytCGayoWX5ncwdrH8QkElmR9lgpEru/YIg/aYM2XqBgsq2foSqg
 BtpCXC6HeZZaBpf3NlMlZhH6bZ0glzTr6bpDZY3aKrPkE03w1x8Y9aVlW6c8Fc1xmQbQ
 XGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788733557; x=1789338357;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yagXDdt/EXPs9+Fn5yPiZj+H0jEXPpISU9Tk/oZrPSA=;
 b=Rdkdnx1cTS1MYpJ2kPb9Sfe61clsU+q2uq3or1X5tdN77u8yksixva/FepBba+WSAJ
 YiWduEVrxpzu22ZZkGGYxqRk42gESfpzzRBJm81GzpxW2JTArligNC11+AbCInxPGXfO
 9S/TLgGv09HpMJ1D4fIj7KU9NNdukajSR9dpOk2k3uBkI43YrgepN9V1hRro9az+34zR
 M1tlQIOJ+JEJH3RwIFvtabzSU15W3TzHvj49hXvaDT+vZNhmsySGfdo99XP58xtBeLdP
 x3jwsjWNgHnotnRo64mw31lBVbvi122vkfJcCN+X4qjpBVG6qF+rR43sIULzoooUx+r7
 4NhQ==
X-Gm-Message-State: AFuF++m9Vgphq9hXRdNts/wQqbibT96avR7z6E2JZOb/+nJbNq+25dxt
 ZymV/8Ia60EcCFebbI2bCXN1KQhnRJAgrnDEHAlW4m/ixjgUZlsdRAp8JkC7eIe9MtNnLnMfwG3
 cuAf9pJaBxgSWuwKvrnBi435Vu38r8m/rpOqg5Myg+OqXH1HbJyLfcwDm5+eBb7BfCQ==
X-Gm-Gg: AYBFou26yUJ41m1jnFE6UECNH53J7Q4x6+rSgp2gHld55/TOr2jkWBWUZQV7IPckvDr
 zc6TNO9pqdv39Ak3fxzQ4JaWAh6ub66rgU6oU1vEZSWcuzLVnxobhv1mXJ1qz2G5fb/1dMYi5Lu
 fmUHh/f4JNNLd6ADAgS1bTyJzHYhYg+GL/QtP+tvmFyVif8646jQkWEfJL/g9EKUHHCpIsA3XQ7
 7NvycAkW/Ohlds4UifROW9feFSLK5zW/kS1RWzG0ptjnCQT7y3NpYfERGrqDaDgJ27rL/wyIFMQ
 OvF5MY46ucaQyLATPttR1A1iwqTNNoJDRSEP023l+F89UBqSP9cg2HnmVCWrdrB3Va2AZfmuImW
 FaMo9FWfKt4PNacfMcmxGoy47yYzpRF0OJWDjBog9uR0jcX72
X-Received: by 2002:a17:90a:1c96:b0:39b:66ee:a14 with SMTP id
 98e67ed59e1d1-39b66ee3442mr3244359a91.25.1788733557080; 
 Sun, 06 Sep 2026 15:25:57 -0700 (PDT)
X-Received: by 2002:a17:90a:1c96:b0:39b:66ee:a14 with SMTP id
 98e67ed59e1d1-39b66ee3442mr3244334a91.25.1788733556613; 
 Sun, 06 Sep 2026 15:25:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm34936605eec.15.2026.09.06.15.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 15:25:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/3] target/hexagon: Fix semihosting STAT filename handling
Date: Sun,  6 Sep 2026 15:25:50 -0700
Message-Id: <20260906222551.3712954-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: dnqGpPaFw7GMM79ZYfedNAFKwOlhITew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfX4JYFLqZEmC60
 FOJc9dy/5X4FIvbFydzrJZxnWpCkMnIdptZv6FKLwpfgza5X8IDMVRYR6spgZRodKAIPzjvayqR
 MgBbdw8scZNBLAdyl0GvwVpvFu5MMvFpjvcBq4ME+tA6raNHXXg9gUj6eUrPgcjFFhZCwCYoIi2
 R6NROehJxLKBtOF0uQS+anl5clnULU4LPuwzR4SYFGKlIFK0BF3CVFdSAN7O1Le3H25+Siqh2dW
 NLqn2knHaFNYshVr+1FmDXQBL+TC5w3jAywrZSSHXZxw7CIqGpmOwezU2yxOOMgFp+r3NnPOXOo
 inmG+5TRYIfOq2H/r0V/9I0M5yemPbL5byts2cQZJ1eSjLlWxqWzJ/jaCfcP+2Db9iRppp5xGgX
 UB9qB+ZU+Oc6/C64A5L0c8xyEzT4b3+xov1uXrVhNRP/giAdRYKJwwRkOf4hk1UebFVulU/A7pn
 rJH1SWWVyOAJ7L3jOnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfX3wftCCc6fsQI
 OeeseM/2Zxe0rMRjMHHdKYD6MV9VJKY9IOQx4H/p87ITDC0MANdGYpjoFtMRA0Vhi97LXSajcBz
 sdOpdF556VFKVoC7D8/pkH6ev41pwbQ=
X-Authority-Analysis: v=2.4 cv=OceoyBTY c=1 sm=1 tr=0 ts=6a9de876 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=SeUakuFykayKsU5LqBsA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dnqGpPaFw7GMM79ZYfedNAFKwOlhITew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060250
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkgd2hlbgp0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBzYWZlbHkgbWFwIHRoZSBndWVzdCBzdHJpbmcgaW5zdGVhZC4KCkZp
eGVzOiA3NzExZmRiYTg4YiAoInRhcmdldC9oZXhhZ29uOiBhZGQgbWFpbiBhcmNoLXNwZWNpZmlj
IHNlbWlob3N0aW5nIG9wZXJhdGlvbnMiKQpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2aEpiMmVtWVoyYUxTZS10Nml3QG1h
aWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5jIHwgMTQgKysrKysrKy0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2ku
YwppbmRleCBjYjZhMDYxYWYxNi4uMThkNzNiNDkxYTAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2hleHN3aS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCkBAIC01NDQsMjAgKzU0
NCwyMCBAQCBzdGF0aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52
KQogICAgICAgICBzdHJ1Y3Qgc3RhdCBzdF9idWY7CiAgICAgICAgIHVpbnQ4X3QgKnN0X2J1ZnB0
ciA9ICh1aW50OF90ICopJnN5c19zdGF0OwogICAgICAgICBpbnQgcmMsIGVyciA9IDA7Ci0gICAg
ICAgIGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAg
ICAgIHRhcmdldF91bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB0YXJnZXRf
dWxvbmcgc3RhdEJ1ZmZlckFkZHI7CiAgICAgICAgIGhleGFnb25fcmVhZF9tZW1vcnkoZW52LCBz
d2lfaW5mbywgNCwgJnBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsIHJldGFkZHIpOwogCiAgICAgICAg
IGlmICh3aGF0X3N3aSA9PSBIRVhfU1lTX1NUQVQpIHsKLSAgICAgICAgICAgIGludCBpID0gMDsK
LSAgICAgICAgICAgIGRvIHsKLSAgICAgICAgICAgICAgICBoZXhhZ29uX3JlYWRfbWVtb3J5KGVu
diwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGksIDEsCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmZmlsZW5hbWVbaV0sIHJldGFkZHIpOwotICAgICAgICAgICAgICAgIGkr
KzsKLSAgICAgICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiBmaWxlbmFtZVtpIC0gMV0p
OworICAgICAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKHBoeXNpY2FsX2ZpbGVu
YW1lX2FkZHIpOworICAgICAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgICAg
IHNlbWlfY2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAg
ICAgICAgfQogICAgICAgICAgICAgcmMgPSBzdGF0KGZpbGVuYW1lLCAmc3RfYnVmKTsKICAgICAg
ICAgICAgIGVyciA9IGVycm5vOworICAgICAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIHBo
eXNpY2FsX2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAg
aW50IGZkID0gcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgICAgIEd1ZXN0RkQgKmdm
ID0gZ2V0X2d1ZXN0ZmQoZmQpOwotLSAKMi4zNC4xCgo=

