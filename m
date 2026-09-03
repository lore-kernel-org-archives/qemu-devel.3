Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897D4C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cc6-0000Zd-4b; Thu, 03 Sep 2026 14:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc4-0000Yt-42
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc1-0000Yr-CV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G39vF927750
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PDUTVxdbtqz6HDwF25RIQroV6wpy3KD4BQ7i6+l4IAE=; b=GP3uTXB0SVMvYWxc
 iMdq1+XS0wSOzX1Xrj+q4Oq9K+wVTOYCoo4aswfa6KMgb422pTP9Oml+rO7J8qr8
 UVvoozp+iHcM+jNQZs6JknfmJZumIMk0KVjM2Mv94uz/7JZ2OpIMFEzchs5LVLPe
 IXUFHx6pZQKy+BoHZtAz/WNfK8mUOY0jnM3UMANw2bZkJfYeC0yVMLQjnE2W86pK
 RYyzoc21VOEKxTNiLbRkJX51nZFQUhxT9JYW3B6ihOH8OAj0EUkMP4Mbek+dGUFl
 ZSP6Do+CV6LsBeQJBHzjmaqYJ06q4Y10HzznMzMT3IRfXg0DsQ5fvG+OoTkjdnKI
 yxPBoA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx2c4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso142849a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461795; x=1789066595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PDUTVxdbtqz6HDwF25RIQroV6wpy3KD4BQ7i6+l4IAE=;
 b=OvUNleRELM54goj/lhK5myXk/jeIGuv2hHy0aM1rgyoTweo5cxim9LtxvuKKLExfuI
 J9hSWe74LEe7zcovr5QX6kH5I3SnqzJetMMgbY3m7qIfWNHLXR1PrxmCNGWXRLd+Id02
 9UcEVqMbepnfhKHtojhHOwBuPvS+RTip2DAUxmxWXb3sB8ULU2iHTHgtB8PR5OZ5E9m5
 5m8qSm0G5rAfR0mk78ijrDOA52o+11GUsGskornmj17ecLDOS1pms4V/Ia+VBTi0usO4
 +PPyQyw870VL3YqvdPYSS4CN4bb5ViN7OjFjETkidnb9yMT0e5wCRrblAvD4M/VZb93Y
 Bnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461795; x=1789066595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PDUTVxdbtqz6HDwF25RIQroV6wpy3KD4BQ7i6+l4IAE=;
 b=eygcAeZmNjuU+Vac3nElxCid1eoEIF2IhCLPW1izvlDG4JXXnI+q+6LUhZbRc39EoG
 1JFDsZVWT2tCBi/6B6TAZGH42oSfnGZjIvdlWGYny8PuXp3m2Y/oFXF9db7RwWBGljUU
 BLqrk4Ot00TjXXbtUwwSWvBlzyY+AYDn2Q4N9W0pLhkzOpxlNGpRdqcgxleujQx/Fq25
 Fmkl9EpP/XRdqS3e81CMV3pHgKLKNMXSEgZcC9aVtjaiWhehL532pp1zATzoB6Yn2yfC
 K7H7cPJZskoGxhAkpmYkrYczbd5RjOsXH/Sj+L0ZvApQx7pweul1WLj8DFS0XqRSaISV
 b87w==
X-Gm-Message-State: AFuF++mQwi26tr815TFe2xD/Mw9hEMC8dXCUlOswg2xrXtsUarhwkRJt
 JQxZ0xWLxwiuPIeyZnyt/gk42FukocvdkdXIphAGdnVIP7f09qHsp1ySCQlaxd4FSWE7oX7PufY
 shS+7onKbvUa4/VD6SQkJ/wh4kxwyAt2gABYWnQGSNGGhHtiLDuKFPua30QyzXp1Vvg==
X-Gm-Gg: AYBFou3czn9LOpMWrbkuN9nlC7D1MOyWw1pC82eFsu8kjCuV/YnqCg/R2Gk7GCdzaFm
 zgc6eCo9WrBRJtXPsVn9yjwdhaE/XkvNmM9bhCIQgKI5rTemp5HCJg6LGnPA7qVrDxThZdpR4Mp
 fSgyORNCofxrBATIKCAYW+gzWmMAjrCCHw/RMXoHJ1lfcM1wV608i2Bgv9LTkBsZEfMlgj0cqNS
 UMQdUNXHYh9lYnXRsGzjPMnWIrfv2D0GT9IZ6EZ6ugQD0yfHB4CRnvSUBQCZYPxdKGCL9zTe/v4
 AKxdHuMJFSKFF/yMG51vPUQjWiyuRS2C4+rYR0Z/njf566fz1vVO8pagu5M3VR2xl2IXy0ycjlC
 /wP5qBn4NJJ3TmuTjHKHYkPqhOfZ8oHBiXLs8DYkhYW9HSHVV
X-Received: by 2002:a17:90b:5243:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39b2614df1emr884383a91.5.1788461795532; 
 Thu, 03 Sep 2026 11:56:35 -0700 (PDT)
X-Received: by 2002:a17:90b:5243:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39b2614df1emr884303a91.5.1788461795028; 
 Thu, 03 Sep 2026 11:56:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 7/8] tests/functional/hexagon: add tests, update to v0.2.14
Date: Thu,  3 Sep 2026 11:56:21 -0700
Message-Id: <20260903185622.3234171-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: MYAeSevmmCTUklgjP4fYD1AQhoGyZr6h
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99c2e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=Hk3-jCc9Ay6NLlPe0nAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: MYAeSevmmCTUklgjP4fYD1AQhoGyZr6h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfXwQYTIPFlecvs
 iywNI0NQSArYSYXeJ8Mi7rdfYk13vc+30AyDcojhCE7IqUJb42QSvFIT1/b58wfEXYXOaYM9rLZ
 hrfJIRr2xAYEHvq1GFiQYDRFx198E5+n4JspGe5ebRTpI4ydrI0bYUWGTg0bzfIGWuwMeGwmbNq
 /a0enlvJw0dxDV94xBv+WQw0abVrHL5fkbWipT3MrQExFfgkfhUiytwsIY/bvEzQCdMUyCih2T4
 SqRKPBqEOCe5y20Bo3xswAoT1MdPopwHepV/sHXA93r1nlrFs05JJwBRi6BvjCi1P8KVX/zHp/B
 84qtGOQm1F6dYea3OonfMjZOJjWChihvoUK4iPrcs6Be/MQ8mo2ELcUbrxuYrAx6m3HJ+co0jRu
 hH1LAG7LsDq+gSQnnW3K9M4dLOhzqr9/uB0b5TZ8eSMNgP+N8/CelBBQfha8a+H6WrgaWRXToup
 iOXN+lR6aRxI7CdxUHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX72MoSYFjSZrL
 4gmRdmViuk/HZAUZZf/KPw3d09DltaNhs3xRIVeighKh6YipEOc/3OpyzTTRW4zJtcqnTam80DF
 cpUlnR89ljRovQIbOnSje2S9GEHKxq8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
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

QWRkIHRlc3RzIGZvciBkaXJlY3QtdG8tZ3Vlc3QgaW50ZXJydXB0cywgbXVsdGktVExCIG1hdGNo
IGNhc2UsIHt1LH10aW1lcgpyZWdpc3RlcnMuCgpVcGRhdGUgdG8gdGhlIHYwLjIuMTQgdGVzdHMg
YW5kIHN3aXRjaCB0byB0aGUgbmV3ICdzaW0nIG1hY2hpbmUgbmFtZS4KClNpZ25lZC1vZmYtYnk6
IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8IDE3ICsrKysrKysrKysrKystLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IGYzNmUwMTVmNTAyLi45ODNl
ZTE2NzJjZSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVz
dHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAg
LTIxLDggKzIxLDggQEAgY2xhc3MgU3lzVGVzdHNTdGFuZGFsb25lVGVzdHMoUWVtdVN5c3RlbVRl
c3QpOgogICAgIFNZU1RFU1RfVElNRU9VVF9TRUMgPSAzMAogCiAgICAgQVNTRVRfVEFSQkFMTCA9
IEFzc2V0KAotICAgICAgICAiaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdv
bi10ZXN0aW5nL3JlbGVhc2VzL2Rvd25sb2FkL3YwLjIuMTEvc3lzdGVzdHNfc3RhbmRhbG9uZS50
YXIuZ3oiLAotICAgICAgICAiYjU3NzdhYTY1MjQ1ZGU3NzEwYTdhMDhkNzE3OTUzYzEzNjJiZTdj
OGI2MGQ5MDE0YzlmZWU4YjE3NjEwYWQxYyIsCisgICAgICAgICJodHRwczovL2dpdGh1Yi5jb20v
cXVhbGNvbW0vcWVtdS1oZXhhZ29uLXRlc3RpbmcvcmVsZWFzZXMvZG93bmxvYWQvdjAuMi4xNC9z
eXN0ZXN0c19zdGFuZGFsb25lLnRhci5neiIsCisgICAgICAgICJmMGM1MzVkNzQ2Mzg0MTI2OTU0
NzU3YjZjZTU0NDUyYzVmZTgyNjI0NjE4Yzc5ODYyNDk1ZWVjMjQ3MThhNmZmIiwKICAgICApCiAK
ICAgICBkZWYgc2V0VXAoc2VsZik6CkBAIC0zNCw3ICszNCw3IEBAIGRlZiBiaW5hcnkoc2VsZiwg
bmFtZSk6CiAgICAgICAgIHNlbGYuYXNzZXJ0VHJ1ZShvcy5wYXRoLmV4aXN0cyhwYXRoKSkKICAg
ICAgICAgcmV0dXJuIHBhdGgKIAotICAgIGRlZiBydW5fZXhpdF96ZXJvKHNlbGYsIGJpbmFyeV9u
YW1lLCAqZXh0cmFfYXJncywgbWFjaGluZT0iVjY2R18xMDI0Iik6CisgICAgZGVmIHJ1bl9leGl0
X3plcm8oc2VsZiwgYmluYXJ5X25hbWUsICpleHRyYV9hcmdzLCBtYWNoaW5lPSJzaW0iKToKICAg
ICAgICAgc2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQogICAgICAgICBzZWxmLnNldF92bV9hcmco
Ii1kaXNwbGF5IiwgIm5vbmUiKQogICAgICAgICBzZWxmLnNldF92bV9hcmcoIi1rZXJuZWwiLCBz
ZWxmLmJpbmFyeShiaW5hcnlfbmFtZSkpCkBAIC00Nyw3ICs0Nyw3IEBAIGRlZiBydW5fZXhpdF96
ZXJvKHNlbGYsIGJpbmFyeV9uYW1lLCAqZXh0cmFfYXJncywgbWFjaGluZT0iVjY2R18xMDI0Iik6
CiAgICAgICAgICAgICAgICAgICAgICAgICAgZiJjb2RlIHtzZWxmLnZtLmV4aXRjb2RlKCl9LCBl
eHBlY3RlZCAwIikKIAogICAgIGRlZiBydW5fY29uc29sZV9wYXR0ZXJuKHNlbGYsIGJpbmFyeV9u
YW1lLCBwYXR0ZXJuLCAqZXh0cmFfYXJncywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBt
YWNoaW5lPSJWNjZHXzEwMjQiKToKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYWNoaW5l
PSJzaW0iKToKICAgICAgICAgc2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQogICAgICAgICBzZWxm
LnNldF92bV9hcmcoIi1kaXNwbGF5IiwgIm5vbmUiKQogICAgICAgICBzZWxmLnNldF92bV9hcmco
Ii1rZXJuZWwiLCBzZWxmLmJpbmFyeShiaW5hcnlfbmFtZSkpCkBAIC05MCw1ICs5MCwxNCBAQCBk
ZWYgdGVzdF9hY2Nlc3Moc2VsZik6CiAgICAgZGVmIHRlc3Rfc2VtaWhvc3Qoc2VsZik6CiAgICAg
ICAgIHNlbGYucnVuX2NvbnNvbGVfcGF0dGVybigic2VtaWhvc3QiLCAiUEFTUyIsICItYXBwZW5k
IiwgImFyZzEiLCAiYXJnMiIpCiAKKyAgICBkZWYgdGVzdF9kdGdfaW50ZXJydXB0KHNlbGYpOgor
ICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImR0Z19pbnRlcnJ1cHQiKQorCisgICAgZGVmIHRl
c3RfbW11X211bHRpX3RsYihzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJtbXVf
bXVsdGlfdGxiIikKKworICAgIGRlZiB0ZXN0X3RpbWVyX3JlZyhzZWxmKToKKyAgICAgICAgc2Vs
Zi5ydW5fZXhpdF96ZXJvKCJ0aW1lcl9yZWciKQorCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18i
OgogICAgIFFlbXVTeXN0ZW1UZXN0Lm1haW4oKQotLSAKMi4zNC4xCgo=

