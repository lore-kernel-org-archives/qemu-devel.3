Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4A606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ozQ6kIQc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VK8Gv9q+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVON-0000Iu-Cg; Thu, 29 Oct 2026 15:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOC-0000HX-5V
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOA-0003yh-15
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDHWr227441
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hcKKVwO6O3oEaJFSB4RFdM
 ay/lVGUM+yB+jheA0isrU=; b=ozQ6kIQcKI+/wELpZaFtXFdrDzgIM0Px39U80y
 GKj0cfF3S/gyDTmvW1bQPMg9hEPTjAgnKOoaZIV3u/aFeRsuXUrmSmxYvR0Gen2G
 4jZPgDd8nbFO16dZIlCraIpBa2mzfcJwjmdRlNbamBzL8wyKvq7LZgPPpTJAuOav
 7dqNeiOjNIh13buKO96Jv2ICs4h1aEfT1fQtXp9fbX4eHpRNxuTK4RCTUIm+z6DO
 UKYZ2w20AvYI8r5kT9/JXmG5tqRmhzn0t39TOc9Db6xkHbQI8nI64UFTul2y7O/u
 SE8CrXj5v73L1nH7WU4M8TEKr6zUQsp2lTR2QaUitIwj4YEg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fkccq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso8052eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793300532; x=1793905332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hcKKVwO6O3oEaJFSB4RFdMay/lVGUM+yB+jheA0isrU=;
 b=VK8Gv9q+vPtoE5nCxkavc+QYGXsP8y0QMpvjIJgXApRlA2j8iN+slkOifSzBNbVLDU
 TiIoj+HjTuZDH1S81GAqKkLtGIhpVmTMKUShKlh50LuJmJCXBrABdyoXyAfUV8l//kQo
 5OqEdru7iTh952lheR3JpwWbxw8VHYzFtnvosWgKymIQvSTNyun3LFAlTTB3Vu3g35cI
 Sm6B1C55uNQsUuZU20YOsS9Q/MdNx0998ELb9c46ppK/a3w4XvRQr/AahvjQaJFfo0l4
 x8+in0IuIvZXez8oxqH/tiUCEBTe0+HUpegP0kBuHbCw0FVyTUk8ayiNjsjF84+o//Wy
 /95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793300532; x=1793905332;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hcKKVwO6O3oEaJFSB4RFdMay/lVGUM+yB+jheA0isrU=;
 b=BdjAxXR7iFTQEguCxGqBfiExhmCFfSaR1st5CzyGs2uo4k8CM/qnB+/17sUs0abdls
 Iub1uQYSjQDhHC7a9sw3YNzSfCSSZcrz/p8DRFBYOmzKx48yPLXzGNce4B1jqcAY/rVJ
 mr5Lf/gSOe43RNSu56TyDcd74uGbmDWEBTt9E3l5LiMhm+nd5+rvbYZswMhzo/chCfYI
 iAfkeI7QJG5nl05FVysJbwxFhbTQwEE+pKrS5mrMdYIWPIi6qiQ0nCcqaT0RbJedwBi7
 h9QafIr12CRrZnfEhk7pNZf08t+m2P+u5Ov7lzNeu0G2j4P14prBxHlbErMuya80vaUM
 CmoA==
X-Gm-Message-State: AFq9FYL3o3YG9Oaw5UXpG97YXNPIpZzXJHEeBXK+z3QHkKZWNYSHV+g9
 liJ3k/AvnrNF+GcJsgiYAIQ/Q06SEAcnGk7poA/ERGFuvlYP/sRMWIQJbhwpQJ+uTDayWgAMqpm
 zf4SZJme3PoT/yFm990T7p5PbmleoyPDspDD89/j9ICr70qOZRxtBOv5L/sraczx5ow==
X-Gm-Gg: AYBFou23jz5k185449ofGBKMedll31fw09leRr7j/ZSjIJFX/7kq3tPTQZS0H6ValFy
 j4oSjCEEviOhD6uf69Up8+W7KU5SACpVUawOf9Jkk9gKY6Kj0GSvJlTZhGbgm8IuS8RXFtmafxp
 17T/uNpP01MI85AdQrFe8jDhFW3dKH7jnZ9KqhDorh0kT5yIEedBxfu/2bVp10dy7V7CrhEFrFp
 bBh8M4VPAkSQECo5vAZfel6kfIcq9QZd0psMYPu8Za6+/P8FXfwUM56VPzCnqRn2ncLke3SLjAs
 wK6DABlvAjNUQTMNc3vne1J4fhguhVovRbLXB5aH0w5M/R43+8wGDAAIa7kPIsXju8RdIhcMTsR
 n94tABM5kUC2dosKikdlf3S5l7RiE5qm90o8L4fE1PalRCrPXaLIB+25uZTFGzRBP02EkQOn8P9
 3P9Sf4AyActoZNnTUsQbOzkA==
X-Received: by 2002:a05:7300:ff42:b0:369:f231:4707 with SMTP id
 5a478bee46e88-36a42225abdmr333190eec.5.1793300531171; 
 Thu, 29 Oct 2026 12:02:11 -0700 (PDT)
X-Received: by 2002:a05:7300:ff42:b0:369:f231:4707 with SMTP id
 5a478bee46e88-36a42225abdmr333156eec.5.1793300530120; 
 Thu, 29 Oct 2026 12:02:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm480598eec.28.2026.10.29.12.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:02:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/6] Hexagon: MTTCG + direct-to-guest
Date: Thu, 29 Oct 2026 12:02:02 -0700
Message-Id: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX3w3lvncPzUql
 TCebfMBdaURneWVBJpORfNV3VvIqweg6oPMuOSpJSVoaEMc3IhehdF8UO9aQ4v6/+8zV0a5jK2R
 cHT9BQJbqATW0jcKmVyST5fjGNIrMScWIcU5PaNYuV4LelHx/6lzhTDSK4eFOeZ8e0kPDg+5VeT
 AfRuc2U08zFqwDqwgBn8m+qGFyR797iJsgRoTpahdtNk1OuvO6TogZl8CZkqf2SyKEjsRVutRFa
 lydJA5x7yJm2Tlw/6nuAamlioQ6xRxzVqGW5EX6xiCpWWQXSleGv/WQCfd4i2PSOq14ZruqwCHN
 7pl6fDTBp9BodTkUrJvL4tbf5IM/7bsrUqOAoEC1B/SMcoDl0+20tgT0TSI49Y/Lwd5mspXgvFE
 jRhq2eLars49FUmhooI3dBvv+/gtxA==
X-Proofpoint-GUID: 0M9Ecf993BVvUxHiMtEU-yVZhbMGaLp1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX1NA8g7i0ktcx
 G2RdU4oBI8FGic89tNRar9rI3h/aaJWovaxpGVIcKuPHEL9BmptK1zW+KUzZAhr9JoUp6YsMcj5
 fX6eVuo0IJ+x8mXnRX4V4dgNbTOkTg0=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae39834 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_Jo2duLxmxjd6j_r4o8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 0M9Ecf993BVvUxHiMtEU-yVZhbMGaLp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TVRUQ0cgd2FzIHByZXZpb3VzbHkgcmV2aWV3ZWQgYnV0IHRoZXJlIHdlcmUgc29tZSB0ZXN0IHN0
YWJpbGl0eSBpc3N1ZXMuICBTb21lCm9mIHRob3NlIGhhdmUgc2hvd24gdG8gYmUgdGVzdCBkZWZl
Y3RzLCBzbyB3ZSd2ZSB1cGRhdGVkIHNvbWUgb2YgdGhvc2UgYW5kCnNraXBwZWQgb3RoZXJzIGZv
ciBub3cuCgpOZXcgdGVzdCBhc3NlcnRpb25zIGFsc28gdW5jb3ZlcmVkIGEgZ2FwIHdpdGggZGly
ZWN0LXRvLWd1ZXN0IGV2ZW50IGRlbGl2ZXJ5LgoKQSByZWxhdGVkIGVhcmxpZXIgc2VyaWVzIChm
aXhlcyBzaW5jZSBsYW5kZWQpOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIw
MjYxMDE5MDYwOTExLjE0NzkzMjktMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlh
biBDYWluICg2KToKICB0YXJnZXQvaGV4YWdvbjogZG9uJ3QgdGFrZSB0aGUgQlFMIHRvIGZpbmQg
dGhlIE1NVSBpbmRleAogIHRhcmdldC9oZXhhZ29uOiBlbmFibGUgTVRUQ0cgZm9yIHN5c3RlbSBl
bXVsYXRpb24KICB0YXJnZXQvaGV4YWdvbjogZGVsaXZlciBldmVudHMgZGlyZWN0LXRvLWd1ZXN0
CiAgdGFyZ2V0L2hleGFnb246IGltcGxlbWVudCB0aGUgZ3Vlc3QgdmlydCBpbnNucwogIHRhcmdl
dC9oZXhhZ29uOiBsZXQgYSBsb2NrIG93bmVyIHNlcnZpY2UgaW50ZXJydXB0cwogIHRlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbjogdXBkYXRlIHJlbGVhc2UgYXNzZXRzIHRvIHYwLjMuMQoKIGluY2x1
ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5oICAgICAgfCAgIDYgKysKIHRhcmdldC9o
ZXhhZ29uL2hleHN3aS5oICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKysKIHRhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaCAgICAgICAgICAgICAgICAgfCAgNTcgKysrKystLS0tLQogaHcvaGV4
YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jICAgICAgICAgICAgICB8ICAgOSArLQogdGFyZ2V0L2hl
eGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArKy0KIHRhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgfCAgIDEgLQogdGFyZ2V0L2hleGFnb24v
aGV4X2ludGVycnVwdHMuYyAgICAgICAgICAgICB8ICAxMyArKy0KIHRhcmdldC9oZXhhZ29uL2hl
eHN3aS5jICAgICAgICAgICAgICAgICAgICAgfCAxMTMgKysrKysrKysrKysrKysrKysrKy0KIHRh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAgICAgICAgICAgfCAgIDIgLQogdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8ICAgMiArLQogdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICB8ICAgMSArCiB0ZXN0cy9mdW5jdGlv
bmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgIDEwICstCiB0ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSAgIHwgIDE0ICsrLQogMTMgZmlsZXMgY2hhbmdlZCwg
MTkxIGluc2VydGlvbnMoKyksIDU1IGRlbGV0aW9ucygtKQoKLS0gCjIuMzQuMQoK

