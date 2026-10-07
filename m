Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59801CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWev-0003t4-1K; Wed, 07 Oct 2026 14:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWet-0003sv-NT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWer-0002eX-VD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IAtBX3679223
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=d50qODtBFrmJkp5mkdBnNf
 0nIFjkFx3MktkchJlfbzQ=; b=OyOhp35NThs/HESNOGhPCADQ+wWK4XY4kbK2BH
 gESkhgi84lYxKqvp0KnKhVahuZyTPDQgeQ+13Y7v4cFXUNoj4rNpwL0n95EwHQUu
 lQCC7oX9lk4Wb/Y4w72yZDP69uwoF08kaoIgQschQ6qcz4DyT6H/0wo+Xc9hgQK0
 axBH+aeosjttpZGEDXVeTS7GgQqoTukFjVIk0XfE3664DaHGah1xtR59ifKpi6lM
 NQM/pknkZjmRDDu9OGWEyXOjH76K5E+zz3o9W720lbtc2pkYstaz1qwjm1bYUbum
 tsUKrlHC6jRNjrdQPFuUmNWlr+HjKnB/FimyHA0qELXTJICA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mge1yc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:46:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510562ef98so5804605eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398787; x=1792003587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d50qODtBFrmJkp5mkdBnNf0nIFjkFx3MktkchJlfbzQ=;
 b=LS0xig87KSsjqESQddFDpVrYKE1ne0qQAb4UNkSddy9WtT5zdR2pMC/trfAoXhOP+b
 A88zqoz42SbXCqxdnwWRtMYyKksBRNFtdOE1ERGKAegsekjqExaqy4+aG+P9ucGQSbjr
 xWJKsoEpAJiDijzHIRzNKGhZgPBOpOIKeCMuHBotQL3J1N3PQEV0zSXnim84LMfzG6yq
 rMMcWKfADtiFrfVU3pNThxmSoYqTb53qhh6bfLzADQEuwtwyISSPGelEuEnnsr7Aa2Sl
 lRL53o9vbn8v6y4XfxaRJpcn94OKVaeA7hRZgkNq7NjkeSwvTfuWNfFgRPOvHClcaoQy
 UxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398787; x=1792003587;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d50qODtBFrmJkp5mkdBnNf0nIFjkFx3MktkchJlfbzQ=;
 b=Do+lETsCUqVGPf4aKpo9YZfAPCmAHBpJvm27JRFbRI7IV/iQtFBo59JbM6ekUZmklk
 HsHQKFfRU1SuBSxhSvAHz24/SVRpskkj+Wftp6XGgpyK6Mt/b2YWt7j0K7N3udx+lhGT
 HqSfwAyogfAjEJU6n1w+hY8TBnFva2y8c3Ho4nr0KZ9WNc/BxwwsV7JSqU3Nt/ppRCbB
 pfwkkQIZhJBe0ZsC2ziLpia5Hdf+T1kjAXHE6dFXjvkA7iADAffPqBD5bn9UbzHHX6Ae
 GQ4ZP8H6KMcblpCv/+YalmbSW95qLKQ2c49tTHFqrhRz5h/Lt5fpKhMZDlAVlOV9IPfg
 fOzA==
X-Gm-Message-State: AFuF++mqRj2eNDXFMC/diWv1Y+6rVv4+GUwanumzfKiULhofO+QQ0VRs
 GgH62ZZST9pgQKjNe5t1F4L2rrqIkRl/7FPKRzaZS3F0ExRc+xn9vOnEPnNsqTjvFYdFfHoLwfl
 PlfyglGNFmxzL8Uk4GahpSIsa49Vpgd1oSu0aEV4ftGMMFEuxi7spXHf3+xp/VpGPmA==
X-Gm-Gg: AYBFou2HtusLeoUh3Lxv2FEF+G5+mP+up1rog6+ckMscPkVGj7NvRr1xLz290qcXw7t
 /23gfpBKylg1Pzk0ZhAyG5fjKX+DNTo0QuXE4m0LXdvxS5xG8aHEL2uziycdw69nq+mBe4M6mTv
 KwtTUn7X6dJOfXrGJUkC30Vg6OIQx2Hk7pRxVQpiIdUg0I/BPEHFohsrnL+9o6MuwTKSSR2Z/t6
 bxcm/LVTXIbXJrWNZ2aGTOmz0rFpWC3V4Vl/my6YIAB/xE9xip4OMmtGszrY6d5dvR1gq/YQane
 +oJux3uvVg/7adRaUzZNEmm/3hbf4sxkQEHr/1qFdG7XdKcI2jIhXYq9cp9XBIOoFvk3940kSia
 V3yWMtSCJcSm5y4MjDByzNP2Q+GY8m9+PFpOX6riYKQWmHFr9FvJaIJrfzKIe
X-Received: by 2002:a05:7300:2691:b0:33e:3f5b:3ff6 with SMTP id
 5a478bee46e88-3515dda8647mr3116464eec.18.1791398787108; 
 Wed, 07 Oct 2026 11:46:27 -0700 (PDT)
X-Received: by 2002:a05:7300:2691:b0:33e:3f5b:3ff6 with SMTP id
 5a478bee46e88-3515dda8647mr3116410eec.18.1791398786081; 
 Wed, 07 Oct 2026 11:46:26 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af3ad13sm8295910eec.14.2026.10.07.11.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:46:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 0/3] target-info: expose full target variant
Date: Wed,  7 Oct 2026 18:46:09 +0000
Message-ID: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX09ay6OLQWYlP
 e15p6r8CPDpLQeJ72R3owTbIhZgrzLtYKicBg6AJ81FTcWiyAphdv147DIagrLxeonE8mZb4zAq
 Kyhp7BdqWwVx8ibi6tsmrTxH0yEeQ0g=
X-Proofpoint-GUID: mFV2Gp8J0DbZ7gH9m0F_SML53eszr2s_
X-Authority-Analysis: v=2.4 cv=PdJqFShd c=1 sm=1 tr=0 ts=6ac69384 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p44_kfD4ypdLu85DTYgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: mFV2Gp8J0DbZ7gH9m0F_SML53eszr2s_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX5fl4cT1tX6A1
 pZHGz6HdfQRj8OArX6jvISt+dvD4//8bk8o7amrDcSiNzDypZRTNA6Jx7MZEdZpv6s8T1RbHZVi
 l5wNgIQG9WTcf8zLe1stHMyzA7AC9Sx2yckIqx1goCFCsKtgujds+BRzhqgAdkEpegqYW1y7L0s
 yWFnIO0I6HJnfqeEOzN4AfJxfNBMwoz8DUtpk8oz3AlEZdB+f0zUY2QU1XIXlSp62DH+WIwjjD8
 JZe38lwd+dPShSKddBrAP6YDOBEkaC92xz5VefhZsHGYVpAnItmqqCQGQvCnj7AVuzq38Q67PC9
 M5SGtwmCoDuaTN98m0FoXNjgCRGUagdpSpI9qT83fKO4YsqOQivXM8yXCVV8/iiP5BDiwSkWZbc
 IwLyj6HvFGEm+q3NQCSDMXIE1RDLh90Myun4sRRow7G7uPUy6/hKLZmL3ZKCENAPAWgvEN/Z4mZ
 iB6i9a2t3PCZMc6LRUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070074
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

Recently, a regression was introduced that restricted list of targets returned
by target-info by ignoring endianness variants. As a result, qmp query_target
output changed compared to previous releases.

Fix that by exporting the full variant, and use that to define arch in
target_info, thus giving us back a 1:1 mapping with SYS_EMU_TARGET enum.

v2
--

- Add Suggested-by for Yonggang on two first patches
- Add test patch from Yonggang

Pierrick Bouvier (2):
  meson.build: export TARGET_ARCH_VARIANT in target config
  target-info: use TARGET_ARCH_VARIANT

Yonggang Luo (1):
  tests/qtest: check query-target architecture

 meson.build            | 11 +++++++++--
 target-info-stub.c     |  2 +-
 tests/qtest/qmp-test.c | 13 +++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.43.0


