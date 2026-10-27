Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABB60A2607
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WBpnWhnO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=akgqKHUu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiMI-000516-6y; Tue, 27 Oct 2026 10:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKU-0000Al-26
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKS-0006DA-9E
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDo2WA3449558
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1n8WBnWvftaGJF00KAEMYrWQ8gMtQouGBD4+2pN6Pdk=; b=WBpnWhnOcpnwaX0H
 m7FGZPQ4KJVfQWll2i2enijDpMv10OrUMu957gij6dLo3+yobhsyJRtQ1CuBR5gR
 GJe68CaZED6OP5vf+lF0R4NDUer4D2a5gb2Sty7pAWo4Ta0fxigspDGvSrB5BfYr
 I8Gj4Zwhx5waJcG4sAivRJk10tEk0EN7eLJ0/PSefCYBxPEbH6kyuY7aIPsJYaWA
 cnGqEBDzl8PK+MOh0tymbTI7tx92qTrzmPeijkUzQ3pMojfsMiWbg/oGsQ9yZPpZ
 XlOe9ObjQaBJtdMdAifW+shB39WBde1XZAarVdbfxIL0YcEL0WnilOz51wG44pr9
 lOX5Dw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91b0ap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso3698289a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111946; x=1793716746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1n8WBnWvftaGJF00KAEMYrWQ8gMtQouGBD4+2pN6Pdk=;
 b=akgqKHUultVzgJh/Clb+9wXYHP1eRpZFrCrDgFxE6EdF78FcFS9vz2IJcJwiqI8fOD
 99xhSCSMO0nbhtvIX4EAfIXRLQyik2jVkeGnVMYARvAhJKasF5stBBcuL2IhnOSr2iA2
 ZSi2hUBQho9KIp779cWOgZC5c8HCcHJ6SkoXYqzCpVYTdP0ZUL6qhPICX+Z/uGs/9MH+
 +hIuP97J5nk0sUSL8MWG7bVNBJpJImL/6DT3K2L/bAt0kCELEK47uu51/kB81VbsWkIM
 zQz5tvHQ407F6zSrAo/tW3jvIaH7e8a1gnrxSsnaK4oyyCA0yn/XRPz3k+6wosCp9BI2
 N5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111946; x=1793716746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1n8WBnWvftaGJF00KAEMYrWQ8gMtQouGBD4+2pN6Pdk=;
 b=bqeLKCmUPUSoQoH14lHstVZUCF1xe7J+xWmiFric8X6k+5uDIt00T5G4M9x5OXI/0f
 w05ebZNYEhVXPyiDRbfr1wOutlNAtJgPOsoCOaEZShQrzHQqiIdnd3H/71TKIvjM46ZU
 Ar9Od596+jVL4xn2s6ecb+IFsYIYHbOHpwVJQpwxHSH4xgBuf7HNs/lMybGbRE/K9rJZ
 fz5OClnPyQc6FwtqCjyxUvh4fYDMu6HMCW2VSZ/JRS3rTE6wCPR1QTgUru/13llq+GIC
 CE6HO9qq+dv+KNrArTlptnoC4m4b5/yhYgUuX7t2+jvABLKHpZxipQ6J4QOyKgdE156z
 QtLg==
X-Gm-Message-State: AFq9FYIYRhW2I5ikoroAxl/SIR5d5YU4JHbvaavAA+H3lyD2NXbuXek5
 9vii/h2dSoRBjA+DbzQVJjysVNJSzUiVOj+ARkLFwxEKrD+TiBBjZmmcddmSjL2DNSIW9kvFkqG
 mv/AbDR61eafG6+Xx+6vpDomqTMQzi+nacSIzNCE1zG+ElZjE9+NHpCZLtg+cunfXHw==
X-Gm-Gg: AYBFou3C7ccnBajYui2m/4AdacJD2ept/4jibiKuyxM1CXwVnZ1hCBbXcCQfxd0DE1W
 sMLkzUwIU1mgwPAK+MgDeBs5/wgf048DfiKqDW0LbAbQeLAQcO0o3c2/acOny/qbBorvWXkB/Ry
 uwdOWAkzBw5uXVK6GLOeob9yaK5fvdzV9n3KLZ/QoXqlF2xn49pgQVMEV3lw/TZ8FZdKyiQH1+w
 GGjBc5G2rl/8RUYZ4fVkyRsrgNrgFtiSLqYCBm+cMhyEaeUlyQyL4Z84cFxX0o1s91qqGNyzOEt
 KwCUNH+feyVx7MT5fT0Jscd9Smfll7Fl9WS4TMm7/nYLG9jeBWi7Tde3BNP+3mrsc0JpTx7R/8B
 MWLKe75ou9+HZ6kjUS2W9C8ExnMK2RqtuMfJhxdrWbXmJSto=
X-Received: by 2002:a17:90b:1fce:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3ade9a35fb0mr8797264a91.6.1793111946258; 
 Tue, 27 Oct 2026 07:39:06 -0700 (PDT)
X-Received: by 2002:a17:90b:1fce:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3ade9a35fb0mr8797240a91.6.1793111945738; 
 Tue, 27 Oct 2026 07:39:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:39:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 37/42] target/hexagon: reset implicit USR write state
Date: Tue, 27 Oct 2026 07:37:16 -0700
Message-Id: <20261027143721.4125584-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Bc1Gnfjp70q6JAd5cfelPMU4dmSR0dbw
X-Proofpoint-GUID: Bc1Gnfjp70q6JAd5cfelPMU4dmSR0dbw
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0b78a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6XX9eVd8KyvID48HtZQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX/Axo3biUD6s5
 G1Yc9OWDBh7oGFhKxPkaGsGl8mWrdPL+dhlPWMZ8xmb8P+95DE8G0SAe8b7kpg6mgq3Ro1LgKik
 A8DOCcWE9CbtmExJMon91E3RkFEV0b5Qs6iNn109jY9/aHn7NT/3b8hih3dgCFW4DWhzjqqED1V
 DzFDByOX5qkfUoR7vt7k/JzuacgGaapArSeF99aMoQM9lKL+IG5kndc9dQXBuy0DlhEGZCfBSR3
 OhP3YEwWn0+WTtk6ea8B3JwyDC2nKESZ4Grhc44+hVuxrAVnjX90Q+Gxw//TG2oj8uZZB7r3R6v
 9YhnuomuxsjRdvNE2J8fhtujkFPC0UiAeWrgJs2lEpFJYfsAZHu2pLUcXS3YriZQwyGI6I4VCmn
 Hsb6+F0CDfcQQ7DDtO8+S90uBULHVfmNSPhbh6Rv9NRzNgPdFuIuJImcYMqn2cOVR/R3YuPXlh+
 y9Bz1yepkqPJ8IxwYIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX3qGrfCnjt4W3
 lDeY8tOoju2eh5V2pr3axOL9ceBo8ndwINJp194EMzkQNM9BZHR/R9fBtui93Va7On1GNHQ6VF+
 aam1G5lwJRmj+B4F/S9TjAxfKI4s1XM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aW1wbGljaXRfdXNyX3dyaXRlIGlzIHBlci1wYWNrZXQgREMgc3RhdGUuIEl0IHdhcyBub3QgY2xl
YXJlZCBiZWZvcmUKYW5hbHl6aW5nIHRoZSBuZXh0IHBhY2tldC4gUmVzZXQgaXQgdG9nZXRoZXIg
d2l0aCB0aGUgb3RoZXIgcGVyLXBhY2tldApzdGF0ZS4KCldoZW4gcnVubmluZyBxZmxvYXRfdjgx
IHVic2FuIHJlcG9ydGVkOgoKICAgIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jOjcyNTozMjog
cnVudGltZSBlcnJvcjogbG9hZCBvZiB2YWx1ZSAxOTIsCiAgICB3aGljaCBpcyBub3QgYSB2YWxp
ZCB2YWx1ZSBmb3IgdHlwZSAnX0Jvb2wnCiAgICB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYzo4
NzQ6MTI6IHJ1bnRpbWUgZXJyb3I6IGxvYWQgb2YgdmFsdWUgMTkyLAogICAgd2hpY2ggaXMgbm90
IGEgdmFsaWQgdmFsdWUgZm9yIHR5cGUgJ19Cb29sJwoKRml4ZXM6IDNlOTg0OTY2OTFlZCAoIkhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBJbXBsaWNpdCB3cml0ZXMgdG8gVVNSIGRvbid0IGZvcmNl
IHBhY2tldCBjb21taXQiKQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXgg
NDVjYmRkYjZiYjMuLjkxOTI1ZDJkZGIxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNjQ5LDYgKzY0OSw3
IEBAIHN0YXRpYyB2b2lkIGNsZWFyX3BrdF9jdHgoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4
LT5yZWdfbG9nX2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5yZWdzX3dyaXR0ZW4sIFRP
VEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNhdGVkX3Jl
Z3MsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUg
PSBmYWxzZTsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4
ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7Ci0t
IAoyLjM0LjEKCg==

