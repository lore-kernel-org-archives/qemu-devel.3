Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05891C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrerF-0005v0-BV; Wed, 05 Aug 2026 12:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrerB-0005uM-48
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer9-00035q-FN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVTgY303082
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pa/vHBeMu05iIQgsx3+EdhDKT/fOx5NVPOKgX7b+9ks=; b=J4z//OdgVaozjoHU
 JBnfWH2VHs1wj9FxOOoBNy508ZTso8dM+0Fw9i6dT0aEKuDcLJscIpHkaSlMKzxv
 0Czjlo88dYeNPosxOoWXaO0YQSbot//1ST+tH3SnDwOWpWm4daiKcLI0nlMIVBhp
 pzNxMLNsO2zHbuWY1vQZMpQkgRsJ5jV3QOTbXSXTWLe9l+hdoBjLMltRlongtBDz
 gw1zTXEFRKrbfXsU9GSDQ3cnBW2h3Nz5BSMl8M2BssDCSUQCtJU9y1kXC01tv0q2
 S5zTRz0eUGYMN94aAeE0RT7ZJojkR9lhhuLAtmC2lQT4AAmpCt+hjTMxbFeP+ad9
 JqWsUQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuu3um14s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:52:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so70841a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785948757; x=1786553557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pa/vHBeMu05iIQgsx3+EdhDKT/fOx5NVPOKgX7b+9ks=;
 b=M3hrhcpXj3EOdcFLrFAAXz2mY5jn3XcmDL6l1t1F540ZUJa3JH9uhP3zGT7Ah5iZ9C
 4ZREY0H1MRotdf1Gq6bEq3O/KGxNEhUtSyJVLoyLuTqpF0PWGwsu6PvA4HASWJz9L/v0
 d2gfxIQufQq5CTLOKtHx0/OwV9tJiq05k8vKS3Lo2aLjTEg1EdsIx66m1eYfZR+cYuCC
 TazzccGCpwiAnE4g6Uh0Plg5Lqa5ugqCaHGQ5lsRvCwsxbvzL2CgSS99Yt6yIeVBiIXR
 EBnvgNWzJqV93WbhbEgf49aivYev+Q/VMjpaHuKIIBukGnQElsH9j0RkTBd1x37ndh1n
 McNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948757; x=1786553557;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pa/vHBeMu05iIQgsx3+EdhDKT/fOx5NVPOKgX7b+9ks=;
 b=XXsUMXtk1tfpYdVoUF28/zapHW2yC2ujC1XEM6BmcEBMYX3V5ofAdlvveKnRm79EiX
 FOZaQWL98iprZdDvNZOxZgembtibzf4bc0uAJq1MNS6vE2beVKlAIu9aj6mVkEFvrqMu
 jAjHfY77h8ZlFxUJO1drNhtBs6aQ0s7Njjbh2l0Xq+GLV0bfU2HYNS8sOocokTvnC7fG
 gOxRynJ5SZMn+q2G4rD+yog7AjHpRaiwE6CokyiI9C0tbO+th+fDW/MZqL6SRFpRuymM
 PB30DLQJCeUsYFwylG9v6CXZLiYc1NoWcbSts6qSadAZXfLPJ34pDYDKrkOtIq0Z3d0t
 U7rw==
X-Gm-Message-State: AOJu0YxEMjTFEDb2/5htkWFOK1TQl6JqJE2iiSmmqP/ZXr0cnkbTa1BR
 P0R9lVmnkiRz+fi19U2GAIdUWfxqztD1vP6Uh2/RseP/KOF9Ch7ZLSQnEFKkGPUb+Yn6MmzJtB4
 zBVbwfvBtCNdoa5m9Z1g6Vk9E8fO94UCeU7yvFux3p190Jz8h7C91/FEfw+1AgwJbKg==
X-Gm-Gg: AR+sD11N809xVJp2HqIKfD8KhQqkewadsTEKuuYrn9XOfnDaI5IxuBwaTnnRT0tv+NZ
 RROhXKgWJRsOpYeFX//h6FI3/qByrwU1F33Gk1Pyqr2D3tSq7Et+eAPMzEZuhTXTI9/nikj4J9L
 jxSi6gvY2UfgU67gwipSJvvGtrBgyAktrfYkIO4v1yXTdPKKHEYJ1ANsd03JI8eHgPiFi9j8+CN
 ewlbVNHxZca1L5NhSm6ELvGFh0/VU1OcioeevMOs637GAfo4P9zipBXlCZmU2LD16xE3TRnppJV
 Pm3qnNIXW8ohKrFCorvbEVH24ZFWItVNrYG8KDgWly0xXRzpZVzzwErXmOd7x5KN4sVelLMktlg
 B0mUh3RwLgUQvOTGjLwad2eQk4xkX/UA0XHqIqp9wzyQlkaw4
X-Received: by 2002:a05:6a21:32a1:b0:3a2:c9a1:2c26 with SMTP id
 adf61e73a8af0-3cb9c0a2b20mr556048637.7.1785948756643; 
 Wed, 05 Aug 2026 09:52:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a1:b0:3a2:c9a1:2c26 with SMTP id
 adf61e73a8af0-3cb9c0a2b20mr556000637.7.1785948756218; 
 Wed, 05 Aug 2026 09:52:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm26429356eec.11.2026.08.05.09.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:52:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PATCH 6/6] tests/tcg/hexagon: add HVX test for V6_vsubwsat saturation
Date: Wed,  5 Aug 2026 09:52:25 -0700
Message-Id: <20260805165225.3117924-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX0N2+l/k9GqzR
 XuJ4cxbl83kiOulcAZBUrfW4wPeRpfn1pYqZjg9No9MpHKbp0Of5JE8M336ScfOnVyJf2OSLGrp
 GA78rOuAKBgMaRRe9wdqs/bu6/2TYnE=
X-Proofpoint-GUID: 13XmPm6ffx4aDAEHGew3mvj91OfslxMg
X-Authority-Analysis: v=2.4 cv=B5aJFutM c=1 sm=1 tr=0 ts=6a736a55 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RA-NybDxESvAkA6-_9QA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 13XmPm6ffx4aDAEHGew3mvj91OfslxMg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfXyJrfnnOglYbh
 jreU45gBJBiBrSFXWeIe2vK9JtoIOxYWdyrjZ7dBdhhfOxfgP0pAC4ccVG8bMI3+7teoGRN29En
 26rQYPsvh0XQbr04MEJ8yMD5PJPWQjTV4P9BQBv7J+ZIbIEC3XXzBANQWQjZJ8K5vsXAG7PFgQA
 3V2JixL/JgXMnfVtPn/Z+5fRtu+/48fzgIh4aHzQ4YfNP8OR5OzlQSAFiO0Wz17lQgltYIva2jx
 RTFgnSkg/Sd0Nb2YSyNH8bZmrxv6arsIsxxbQ6vffqCN4T4HlW9JfMzFs5JMo1MgSQKCDjrR5UA
 PHcRyl16yTWPgnbl4JOQ+Ur5xj+gezDjq9//Ip1Sjo6ki8pyidGdfXobgfJHp1k/tJHSAAB8wVI
 UG6mBulT9/7SkEtXtxmpjKbtHOioQwV0lsdXrJsr+sPZFQuLwK32hWbgfJB1MyaAQtrz6Nm+hvj
 6TDDePOBUfICC+J2Vtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050138
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCA0NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyBiL3Rlc3RzL3RjZy9oZXhhZ29u
L2h2eF9taXNjLmMKaW5kZXggOTBjMzczM2RhMDcuLjY0MWNmZjU5YWJhIDEwMDY0NAotLS0gYS90
ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9t
aXNjLmMKQEAgLTIwLDYgKzIwLDggQEAKICNpbmNsdWRlIDxzdGRib29sLmg+CiAjaW5jbHVkZSA8
c3RyaW5nLmg+CiAjaW5jbHVkZSA8bGltaXRzLmg+CisjaW5jbHVkZSA8aGV4YWdvbl90eXBlcy5o
PgorI2luY2x1ZGUgPGh2eF9oZXhhZ29uX3Byb3Rvcy5oPgogCiBpbnQgZXJyOwogCkBAIC0zODYs
NiArMzg4LDQ3IEBAIHN0YXRpYyB2b2lkIHRlc3RfdnN1YnV3c2F0X2R2KHZvaWQpCiAgICAgY2hl
Y2tfb3V0cHV0X3coX19MSU5FX18sIDIpOwogfQogCitzdGF0aWMgdm9pZCB0ZXN0X3ZzdWJ3c2F0
KHZvaWQpCit7CisgICAgY29uc3QgaW50MzJfdCB4MCA9IElOVDMyX01JTjsKKyAgICBjb25zdCBp
bnQzMl90IHkwID0gMTsKKyAgICBjb25zdCBpbnQzMl90IHgxID0gSU5UMzJfTUFYOworICAgIGNv
bnN0IGludDMyX3QgeTEgPSAtMTsKKyAgICBIVlhfVmVjdG9yIHYwOworICAgIEhWWF9WZWN0b3Ig
djE7CisgICAgSFZYX1ZlY3RvciB2cmVzOworCisgICAgLyogSU5UMzJfTUlOIC0gMSB1bmRlcmZs
b3dzIGFuZCBtdXN0IHNhdHVyYXRlIHRvIElOVDMyX01JTiAqLworICAgIG1lbXNldChleHBlY3Qs
IDB4MTIsIHNpemVvZihNTVZlY3RvcikpOworICAgIG1lbXNldChvdXRwdXQsIDB4MzQsIHNpemVv
ZihNTVZlY3RvcikpOworCisgICAgdjAgPSBRNl9WX3ZzcGxhdF9SKHgwKTsKKyAgICB2MSA9IFE2
X1ZfdnNwbGF0X1IoeTApOworICAgIHZyZXMgPSBRNl9Wd192c3ViX1Z3Vndfc2F0KHYwLCB2MSk7
CisgICAgbWVtY3B5KCZvdXRwdXRbMF0sICZ2cmVzLCBzaXplb2YoTU1WZWN0b3IpKTsKKworICAg
IGZvciAoaW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7CisgICAg
ICAgIGV4cGVjdFswXS53W2pdID0gSU5UMzJfTUlOOworICAgIH0KKworICAgIGNoZWNrX291dHB1
dF93KF9fTElORV9fLCAxKTsKKworICAgIC8qIElOVDMyX01BWCAtICgtMSkgb3ZlcmZsb3dzIGFu
ZCBtdXN0IHNhdHVyYXRlIHRvIElOVDMyX01BWCAqLworICAgIG1lbXNldChleHBlY3QsIDB4MTIs
IHNpemVvZihNTVZlY3RvcikpOworICAgIG1lbXNldChvdXRwdXQsIDB4MzQsIHNpemVvZihNTVZl
Y3RvcikpOworCisgICAgdjAgPSBRNl9WX3ZzcGxhdF9SKHgxKTsKKyAgICB2MSA9IFE2X1ZfdnNw
bGF0X1IoeTEpOworICAgIHZyZXMgPSBRNl9Wd192c3ViX1Z3Vndfc2F0KHYwLCB2MSk7CisgICAg
bWVtY3B5KCZvdXRwdXRbMF0sICZ2cmVzLCBzaXplb2YoTU1WZWN0b3IpKTsKKworICAgIGZvciAo
aW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7CisgICAgICAgIGV4
cGVjdFswXS53W2pdID0gSU5UMzJfTUFYOworICAgIH0KKworICAgIGNoZWNrX291dHB1dF93KF9f
TElORV9fLCAxKTsKK30KKwogc3RhdGljIHZvaWQgdGVzdF9sb2FkX3RtcF9wcmVkaWNhdGVkKHZv
aWQpCiB7CiAgICAgdm9pZCAqcDAgPSBidWZmZXIwOwpAQCAtNTMwLDYgKzU3Myw3IEBAIGludCBt
YWluKCkKIAogICAgIHRlc3RfdmFkZHV3c2F0KCk7CiAgICAgdGVzdF92c3VidXdzYXRfZHYoKTsK
KyAgICB0ZXN0X3ZzdWJ3c2F0KCk7CiAKICAgICB0ZXN0X2xvYWRfdG1wX3ByZWRpY2F0ZWQoKTsK
ICAgICB0ZXN0X2xvYWRfY3VyX3ByZWRpY2F0ZWQoKTsKLS0gCjIuMzQuMQoK

