Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65DBC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SNA-0005as-PC; Tue, 01 Sep 2026 13:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN5-0005YZ-7T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN2-00081L-SH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H6ZhK3659852
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbLAd+REvcoJjIvZXB7piBXU7dhyhjnew72IgBR9WPM=; b=UUymvZJTqnZPWzLL
 To5Yk6Lo1nQx0Dw81GsqVREeFcIn3RtW1CQIKEEpRF3FIABB7eB6DICArKLcsHmA
 aU5WRNilqpEBAI/3Qc8EhJbvB/hqOldgnmkw7xd/id2QtTKVwIcr507NmDlehay1
 I/+rGbI9vqDx+/0rIK4lYt5CLxMDQmB0mY8V8b0PZSJq6J4pBa5h184R+Zh89IHZ
 WWFqKTq12aKlCkglA7+UdHp4AXarb3cXRLMNp42qP3+9IOT0F/IXCM0iv5HcHHOT
 3hdcLlu8jztWR9jgBNom+C/tZmNTx8KEJN0yMd28kwZCTY7TFze3b4mdPmDc0EAv
 Xj8ANw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt19uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:34:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so753425ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284043; x=1788888843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UbLAd+REvcoJjIvZXB7piBXU7dhyhjnew72IgBR9WPM=;
 b=JRv3kSS33rY9AQ1tEJ2tvjzYRbNXnlGQSA3r2LyXm4rQWwqi3HrU2KiKjy6jbOoc8P
 AIyhrXWRdcTjJrP81Mexx43D5w2tHRTodrFzn4gj4Z9YhDgaMjlcW5eakFQcKct/Tdql
 glYw2DslQX4L8QQb720kEHLLw+anLPk6jYQYFP8HW/to4ly6KjvnMwEOICJNDA3Ae0dy
 qXco1DJHMnGTZykCt55lEWlwY8roSoiKxStBxQVWFfwYKUFj14jYMqydp5haM8tEbS0x
 noW3QmWLfLFr7uVE1wmF3zkBegh20trW++Da7vzpdqE/P0/Y2GXEUj0tTpd3K9MS5D0U
 Wx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284043; x=1788888843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UbLAd+REvcoJjIvZXB7piBXU7dhyhjnew72IgBR9WPM=;
 b=jEfgmAH1o8Clpthe9rDBMsyxqy8gxp3EH9GHYj4Qhd8FMsFcjLKsDvwboTzTKlJKPy
 doVlIHQoeJqkwO9OeHLwn/9bGf/iK73jdn1X7OfLZbUD1QSSXePZxjUIs6S3DcivoOzF
 tHadbi/QBbTK6MZaC+UduleWeT/D0DrpjyFx0nWdFdzLcSPIdi9ot4iSnhWtiCuH0wQt
 h4b7498nCuMf2n6UTJpmdAn5XZQuqHTE4Xc+hacxlupZ/c1+d7V/GxrzLanvdnSgakTm
 Hsu9pNNFmajKJWtoq5YEr0ioqQ1hU/A8CdZ+86nlyW9ZsC/MHe0XP8owTpB8QdpH8D5P
 ZFQw==
X-Gm-Message-State: AFuF++n5bJtsuRQ/DfRqM6TntYAy9AwaTF5OyU0Y1WnccWK7xThtlZbb
 nF2Zrwtioc2JAcD3jkRzhF8W1q5VPMOCDKM1eRwtQJjBNL2n2up4Zgaarhcro8FkPEgGzfUWVwL
 M3EcGftRoXgLWf0ZVH/daqSxc/9geRCdYWb3Goosgqwi3EgEEDbzKxopn0aZ2KTebOA==
X-Gm-Gg: AYBFou10GKZT3XK2H0zxG+EsxDAXFk5flGP83HV7PoJCn3MX0CrZuuBhdDoX0+ydgYW
 DOSs75NzxtG/as2cHCXJDN4K8VzTCCttSb6mh5yyKjqsaFtV9ZER7NYvFRDZb0B2KT+ChrKSM30
 rfoFtYvRYNyzAsjE+HLqZBIjPwPM8RQcsf3+Uiuk9ZUcES7gU4nZurPTzsK9uJEMpeH+f/Vdk0h
 caokETqJhAbmwbCZPd8Nt8fK3vaxcmFdpGxDoIWYMdnyI7y6erM4wu6lLmc977LK5o8pmdtPugF
 CbqJvWfQok39G8doo5t64Hvnr0r54zFw5/17uOrbyeNBlzEVLQYkvZs4qJl6CDKegxGHz+nrmLX
 AG3bquIv/dEkajOyH0X8S+pIx2OvSlWJNio6EaHHwG+PS0nlC
X-Received: by 2002:a17:903:1ac7:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2d74dc7a37cmr468887815ad.8.1788284042709; 
 Tue, 01 Sep 2026 10:34:02 -0700 (PDT)
X-Received: by 2002:a17:903:1ac7:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2d74dc7a37cmr468887225ad.8.1788284042262; 
 Tue, 01 Sep 2026 10:34:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:34:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 05/11] target/hexagon: take BQL when reading the system
 pcycle count
Date: Tue,  1 Sep 2026 10:33:47 -0700
Message-Id: <20260901173353.200474-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfXxF6ZA38ipnoM
 98hB19FETtgScfTaoxveE2NFov2pQLzEKjwYvfsA9gn51Ej69mOJPyLkqLgPu3PUrFhXAyIEeqr
 OvjZ97UVn7rkK1LNZvdAAnzjJQkE4dmgeMyiqPHlWEssJBwj0r/XE3odNfrK11yVNE4VR/CFlwu
 +L3+k8rRgk7NoRtMy9LpNKWT1mY0xS2Uyf8GxqudPjkBhLHPFPcJY3f0FoKIXo+6QuKX53TNM2/
 5I6Z3A73KUqLJITNWatWffUTjX+ScurcHDYj6dLZ92+QkR1WntQ21HcZLA5xhNGrH8D6nI6xIRJ
 wighfc2BLENZrHQAcXNBRJI+Q6zcJyMdfrVt8bZ7mnjlFtDPvNtiLkTV8IdfPt7PMpcKDVULniC
 znMTwR9R5bc+hxwa66DK0lPeeEGp8F/nNBIrG30oqJprA3dYJJqpe7ufUzdXIBbcAb/ts/FYTyb
 fQ0p3PUeOI2/um3RunQ==
X-Proofpoint-ORIG-GUID: swsUsdCNKwNwXQhaUXru0WYNx84RT20a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX3l+jjJsR6cov
 iBlkJ+TuAhBF1nMg97dgDrmt+cd4IlQj4e1FWQTtyWmBPIqGYYbZTeF44RhKRZPCNKBpkGkzjBl
 oTKIEmGT/FM+iYNmXTVeyUkJ3vUzzb0=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a970c8b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=tKA3sQWDS_42iA0j-SoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: swsUsdCNKwNwXQhaUXru0WYNx84RT20a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010155
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

aGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudCgpIGl0ZXJhdGVzIGFsbCBDUFVzLCBzbyB0YWtl
IHRoZSBCUUwgd2l0aApCUUxfTE9DS19HVUFSRCgpIGluc3RlYWQgb2YgYXNzZXJ0aW5nIHRoZSBj
YWxsZXIgYWxyZWFkeSBob2xkcyBpdC4KQ29udmVydCB0aGUgbWF0Y2hpbmcgc2V0dGVycyB0aGUg
c2FtZSB3YXksIHdoaWNoIGtlZXBzIHRoZSBsb2NraW5nCmNvbnRyYWN0IHN5bW1ldHJpYyBhbmQg
bWFrZXMgdGhlIHJlYWQtbW9kaWZ5LXdyaXRlIGluIHRoZSBfbG93L19oaWdoCnNldHRlcnMgYXRv
bWljLiAgQlFMX0xPQ0tfR1VBUkQoKSBpcyBhIG5vLW9wIHdoZW4gdGhlIGxvY2sgaXMgYWxyZWFk
eQpoZWxkLCBzbyB0aGUgbmVzdGVkIGd1YXJkcyBvbiB0aGUgZ3Vlc3QtcmVnaXN0ZXIgcmVhZCBw
YXRoIGNvc3Qgbm90aGluZy4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVy
LmMgfCAxMiArKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDY0YzU3NDZjNmQ5Li42NDljNTgzYzBm
YSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMzYsNyArMzYsNyBAQCB1aW50NjRfdCBoZXhhZ29uX2dl
dF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgIHVpbnQ2NF90IHRv
dGFsID0gMDsKICAgICBDUFVTdGF0ZSAqY3M7CiAKLSAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkp
OworICAgIEJRTF9MT0NLX0dVQVJEKCk7CiAgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKICAgICAgICAg
Q1BVSGV4YWdvblN0YXRlICp0aHJlYWRfZW52ID0gY3B1X2Vudihjcyk7CiAgICAgICAgIHRvdGFs
ICs9IHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQ7CkBAIC01NCwxMSArNTQsMTUgQEAgdWludDMy
X3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BVSGV4YWdvblN0YXRlICplbnYp
CiAgICAgcmV0dXJuICh1aW50MzJfdCkoaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYp
KTsKIH0KIAorLyoKKyAqIEV2ZXJ5IGZ1bmN0aW9uIGluIHRoaXMgZmFtaWx5IHRha2VzIHRoZSBC
UUwgaXRzZWxmLCBzbyB0aGUgZ3VhcmQgYmVsb3cKKyAqIGhvbGRzIGl0IGFjcm9zcyB0aGUgcmVh
ZC1tb2RpZnktd3JpdGUuICBOZXN0ZWQgZ3VhcmRzIGFyZSBuby1vcHMuCisgKi8KIHZvaWQgaGV4
YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50
MzJfdCB2YWwpCiB7CiAgICAgdWludDY0X3Qgb2xkOwogCi0gICAgZ19hc3NlcnQoYnFsX2xvY2tl
ZCgpKTsKKyAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIG9sZCA9IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnQoZW52KTsKICAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAzMiwgMzIsIHZhbCk7
CiAgICAgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudChlbnYsIG9sZCk7CkBAIC02OCw3ICs3
Miw3IEBAIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BVSGV4YWdvblN0
YXRlICplbnYsIHVpbnQzMl90IHZhbCkKIHsKICAgICB1aW50NjRfdCBvbGQ7CiAKLSAgICBnX2Fz
c2VydChicWxfbG9ja2VkKCkpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CiAgICAgb2xkID0gaGV4
YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYpOwogICAgIG9sZCA9IGRlcG9zaXQ2NChvbGQs
IDAsIDMyLCB2YWwpOwogICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQp
OwpAQCAtODEsNyArODUsNyBAQCB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQ2NF90IHZhbCkKICAgICBpbnQgbnVtX3RocmVhZHM7CiAg
ICAgaW50NjRfdCBkZWx0YSwgcGVyX3RocmVhZCwgcmVtYWluZGVyOwogCi0gICAgZ19hc3NlcnQo
YnFsX2xvY2tlZCgpKTsKKyAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIHRvdGFsID0gaGV4YWdv
bl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYpOwogCiAgICAgLyogQ291bnQgYWN0aXZlIHRocmVh
ZHMgKi8KLS0gCjIuMzQuMQoK

