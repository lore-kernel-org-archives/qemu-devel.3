Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA1FCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnFt-00077v-6g; Tue, 13 Oct 2026 20:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFr-00077J-M5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFp-0004Ji-Q4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLRMhN1404185
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=D+DO50whEVxS27vZG7zOUb
 GAQ/U+sbVLyVZ5yXOozkE=; b=aLAG/XKTiI3ZJlW+5FDqoled2VdZan6igrXnHd
 C3/pTy5EOi/JCBb9+08Kp1/HpQrVpdXxzs6tp/yPac7EU2Sc0W9VHmY/GkI5KgLI
 hExs2O/0v87N/BrnVnoNxICeJIY6ojc2Y4f5nRZ1CLEcRqwC/7dCnfxQ5IIgmfqp
 h/ZXzswSFIpFMVEi+XpPqXs5Mu0qr7rVpt8UA8qd3BU4MTqA1DufLrCjrUb2X+q6
 oFRWJnvhQpChte2KxjuA5NC0E8y1CYZ8BYgGFSB571q8v+Zfhgqp4G5ZbamMiV7D
 9JFa2QwsG233CfKash7B0x8QZ3Yq5KWKAzQQNnQbRpWg8q+Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk2aqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:53:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso5674505eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791939238; x=1792544038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D+DO50whEVxS27vZG7zOUbGAQ/U+sbVLyVZ5yXOozkE=;
 b=cbVndr7ntenMfXM2hs4Xx5gMIxYomaGNqY78dSbCHVmIfsUAje4Tgpx3o8SiXtwurH
 MEg2EoAGTpQVe61aPR7fZyH9wb2sQ3MRrTErLfKyLOKAQKJJuQBoRJoy3+kY+XBmV4zz
 n0YrGVDSOmaTw1Na4gfW+ghrUPJzGyPQAmUTHrTe7xsFbjLFv5p1ugcrY3frcTHOu93o
 eEn4Bz9oasRjWSveJQ43ogUBIFWJh9GCPKN5Cxy/77WOVtdUPn4cDc2cy3LtF3BrZspH
 1tYl33c1uAw7t4CTCQjM8wz1fEskXkK5GVdlK2jqi/ml3+F+CgFAjysMqYwKs9v/lYPk
 c0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791939238; x=1792544038;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D+DO50whEVxS27vZG7zOUbGAQ/U+sbVLyVZ5yXOozkE=;
 b=hgoCmTp18IHD9xuYpoAG5+H3yE0MWwX1Vr1uFCT8KHFhS9LMCoXFNnUq8GlmT+wqM0
 QIE7OQRr5dBM3gVcML7bUbab9lmcPJsn++IFrRSrD+mhewEDrXi4mjr2xR7purfTj91+
 uhdnDwSO/BsCXvYn15Gc+ekySvL/pzJuMvsDxPgJb08T0E0d1xPWY72wtACclQzY4p2w
 gMbKRp0f0mwlehqinwjPdLbo8V2jKkAWxJHd5YETwKwh7klsNnsc1cSd4iHM1eGodlEB
 er5SLpMIi7ymvecz7rRTJP64TA9k3dDOnG9InxCVn2V5QogKT9vGIghQAkra/CqM7AMb
 R9fw==
X-Gm-Message-State: AFq9FYJqS77N+IKd2rlM+j9dX8q98UBMdCqlwd2leAnyGpABfAEyBrA5
 XJp5xawF4tZrYeENE3xmuAWLfvorYybnntIf8hPX74kpyK0lq7PLOAzEswZ2O6Iw/zCdfa4bR50
 cIMalIbJZilngxv+6Y3BBWsNJNA+0ACnpuD1EjGjFLtHJNP0IddGOvPk3ai0Oc25pHw==
X-Gm-Gg: AYBFou3UrmznE3duqTzCNjqpV6hr8D/bcQqmhI6WhYtchjBQ8cPmoThOli/0NFKhTov
 wJlInoG1zvGN1M08UdtbEDGDlAmNBmpg4EpnfTBIueEAHXyaVD/VkFonuDYu1WYqK+g3Nxx88o0
 763stwxknrVmxb2i+YYC/fySL3L/9FIxlV/YOPajBIgQADPLH811pdhZ+rmGeICGhApPEzhyUUu
 2nvn505VlVQjDnieOXAySKbkHvv9uBhEjnn9KaOZTMnG3+pwXdjpOKEcDdEqtUlzWlaDo8k3YIM
 oN5kzjG1aoxxUb86oimU0I275jKy39sBh4AO3/Ops06ARSHBxGFHnIIRm/q7iWlhtV9JQDcovjj
 gtRZyiVAeqpIQPSG7j7OkoAywKtb5AhyRhvbKwKhKmB+qnYktLNeC1u7DYgr5
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-3537df95584mr25532069eec.16.1791939238097; 
 Tue, 13 Oct 2026 17:53:58 -0700 (PDT)
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-3537df95584mr25532030eec.16.1791939237529; 
 Tue, 13 Oct 2026 17:53:57 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm31823564eec.20.2026.10.13.17.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 17:53:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 0/3] releases: build and run any QEMU release easily!
Date: Wed, 14 Oct 2026 00:53:35 +0000
Message-ID: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U6epWWzQdVm0b1SkBfz8op8HOaMh5DV6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX4x07iR1MftIk
 NMq4LFdslEBnz7wZQ1dLxEyh0jZwsbXjtzBspN7PNkrippfD3Rb/PFrHDpuTw2afswJ8E5i2UZ1
 as5wuctecm7AmfO9QEtqhCg5RIcKeLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX545MGvbZMGOv
 9bp+8CAA+xWacObUv+eMVAq8GrtNf5UVGNzt8KYlhwY8LdaSR7jmIs8HanJmf0modLfgnhvKx8B
 LcLRKQtrUCGz0H5ZRMTysBJuyz/Vf4t8x+jlLX4T+1JGJ4aXnDcLQ91E+J2UYDaDpHUKltZkgqV
 z1JFltOxg+yaMCKh9uMwFj3Pie3WQAFRqR0JKmHH6a3u11NfgX2zi7I8FVmhW3JsylAOsS0JK/o
 4DT322RZLOjMCqjPUqQkPDoQiVHLPMDec5v77La9LqHYywBaKhNaCv2rdu/+J7DwH86ntCAn4GX
 DQxqYXoTAp5oWMJkecNWuVpJK+E7dpcb1VYwzFnaZycIGxjZIigaSu+c8IiwXs1RYKpNZ7fO9l0
 jb8VB4/veZ+syX0r7XRTlO0bmDHKz/quj+iK5RFM3P3uYn6sBHjTv+pIbnL0AIMg/KlpylgHD+V
 inPM0MFi4BZOdrnVtUQ==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6aced2a7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4DlUO2TMUbiEHNw8gdkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: U6epWWzQdVm0b1SkBfz8op8HOaMh5DV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140003
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

This series was inspired by a recent post from Fabiano to provide container
images for migration tests:
https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c

The idea to be able to build and run any QEMU (past) release with containers was
in my mind for some time, so I gave it a shot. Finally, it was easier than
expected to obtain a single dockerfile (with a few hacks) that works over all
our releases.

The oldest functional distro we can find nowadays is ubuntu 12.04. Because of
this, the oldest QEMU release we can build is v0.12.0. Previous ones require an
environment we can't get easily today.

Images have the absolute minimal content possible. It's only qemu binaries,
artifacts (roms, keymap, ...), and libraries. There is no shell or any other
tool included. As a result, images have a size from 149MB (v0.12.0) to 1.48GB
(v11.1.2).

This series adds 3 pieces:
- a unique dockerfile to build any QEMU release. User has to provide an explicit
  Ubuntu version when building a given QEMU version.
- A script build_release_container.sh which automatically detects which ubuntu
  version a given release should be buildable on (based on date). It works
  great, and the heuristic works for all our versions.
- a script generate_release_links.sh which creates wrapper scripts automatically
  using prebuilt images (hosted on my dockerhub).

TLDR:
$ ./scripts/build_release_container.sh v1.6.1
$ podman run -it --rm qemu/v1.6.1 qemu-system-arm --version

$ ./script/generate_release_links.sh qemu-time-machine
$ ./qemu-time-machine/v1.6.1/qemu-system-arm --version
QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
$ ./qemu-time-machine/v11.0.0/qemu-system-arm --version
QEMU emulator version 11.0.0 (v11.0.0)
Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers

v3
--

- extend dockerfile to support ubuntu 12.04, and lower older revision we can
  build from v1.6.1 to v0.12.0.

v2
--

- fix generate_release_links.sh: was missing userns option for podman
- dockerfile: cleanup "|| true" and replaced with proper ifs

Pierrick Bouvier (3):
  tests/docker/dockerfiles: add release.docker
  scripts: add build_release_container.sh
  scripts: add generate_release_wrappers.sh

 scripts/build_release_container.sh      | 62 ++++++++++++++++++++
 scripts/generate_release_wrappers.sh    | 71 +++++++++++++++++++++++
 tests/docker/dockerfiles/release.docker | 76 +++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100755 scripts/build_release_container.sh
 create mode 100755 scripts/generate_release_wrappers.sh
 create mode 100644 tests/docker/dockerfiles/release.docker

-- 
2.43.0


