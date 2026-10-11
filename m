Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4237CCA9ECF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFwP5-0001ZM-L0; Sun, 11 Oct 2026 12:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP3-0001Yw-Oh
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP1-000787-OY
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85LtV1945832
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=O/NH5XjlRw01kIg7gpZDVt
 9vb0XnD1umm5gNLLEvpqo=; b=Pl2V43Ry+nXp3Kptuc/VjsMHYuM7i3Z1N0BV51
 CzMvR5uslvw3QRb95Xlr8Ry9WIV+WWFm5LI0OFM7IDpT+6H5m3oY1CEdjgC29xfK
 i5OluhKTdVsxodpLWNcXRR9MFP3TBk+nzQ98XpXGU566ofVkMFZMT0If/cOwpkl5
 W3b2JBS+YPEjAei5XStIQbkuRllKf9QIGZ4ltMA46N5MtLnGxfdf7o8NE5IuOORP
 S4myJg2mZ4BZwhgT7S1bAdvf1blcka9ZXz/Q8Xy2O7sVqYbRzw0bLiB/YL6V3x0+
 B4v8qXFPQR0zCPrx7B5UtCYwW1+muNmljFwi9Nn7gULhN7ig==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dr7katg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:27:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso2197414eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791736076; x=1792340876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O/NH5XjlRw01kIg7gpZDVt9vb0XnD1umm5gNLLEvpqo=;
 b=XYbSPhlWRyNQeZLK84q1QZ2Q0YtssENpi3z4GyxKhy1JP/mmrEKO5iHu/JrFgIbChJ
 TOHkpglbYUgM/7Q37YgC9BD2r1inNUpc9MvoBW/XS0PADsy0PccWMmUm/0ILwzXMqWgR
 hq+RGhS8ucDZZYzcXqlUhTej7ogqCZsgH7OER5GysUbgMOTSTS+uyJWlC0RFllNyLNEy
 K8X6NYpYW56E7xkpNz51J4jb4anfM8D1wC+sI59pF8rjLmL2SHCu3S9ORh63ghL+ALo3
 /BSQ20OjnzNsN8eneQ3OEsFT//jWSXfXPOx38cpJLAdm2qQ2UTwcaQnRvrDf6GONCf30
 U5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791736076; x=1792340876;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O/NH5XjlRw01kIg7gpZDVt9vb0XnD1umm5gNLLEvpqo=;
 b=vbmk1m1aC6hJjHzN+zjCv9+ADflDa/c3ItKMHttWC7pCKCkZ+bhvX4HE6LOnBazNf+
 8jTD0NzqQOta08ZgJm0PajKVpTa+3axJgDkNnXCm1Vm6juurqd7PEvEnx2DQkn9lvqe9
 fpA871OIr4SH21WvdT7NWgb8rf6Yv++/JqFKrYMUWzaTlaJpOui5OLvoC37NHZrsvYmU
 gwHozR5t2JdEZHgXvYc7HgfpL7VhWvn3DCUvGFHhtg4a58d9YYaewbbcSY+wIyUFTnKS
 47JO/1vKop6KwfhDPwaXo7esK/BhkE7pcGgZNRc5w9JZoorCfJb3dW97UqGk3DCclbM0
 3WoA==
X-Gm-Message-State: AFq9FYKjHtWT4+5vhuGype3Ux1eS4HYkxkKFNqrnQAxmcoJRN/B+wkBF
 gho8bS0phZd3frYC2JadhfsAhyMLY0I5It/9jeuAfCT+NfsYQ9VP/eNx31qcvR5DFDPhFq9og7v
 rkeWyGhktL3+PLhoDfY5XJErI8EXwFltkrZ2RjNe076jvnA2as8wx33CYi1zdhMKLyw==
X-Gm-Gg: AYBFou1m/IfLVE7Af+OHoVkL8tXxDfNC5oXgvaHPow8Z7aL7tlFSkKyHqFUwbpnMTDY
 BI+VmErh53ZHu4n3Hw7Rt+0MY8KOy0lC10Xk5JY5F8sY8s8kIONUq9QQLv/N34Y2qMKQs0PcC6T
 /av20kB1ymX1OIpwk6FiGkEpsdv4ndRnKKImh/leOVAvvwVEYZcMQi0GFasNwPUXYAHQ7bLje+h
 oSzNMhI9yVxoIbatcUM1CquW+Ko3RZE6zha1ut3XiXCePC15tNqyaZOlm36k+/pxHkP4FP7OcxD
 rlTWAXo+cn6JexNEAyBLsr2MGsu1w+2wXeE7SfN67CaopM6Bh9x5PSBgvdtNMw3UkQg8Mp07gom
 sHTQz2jucTD2nrW26Tf9LWHH42DnF5iHzgd4AKADROKQXHVynUeVwIuYlYq/o
X-Received: by 2002:a05:7022:1605:b0:14d:baf5:c412 with SMTP id
 a92af1059eb24-16a5fc91757mr12084349c88.8.1791736076194; 
 Sun, 11 Oct 2026 09:27:56 -0700 (PDT)
X-Received: by 2002:a05:7022:1605:b0:14d:baf5:c412 with SMTP id
 a92af1059eb24-16a5fc91757mr12084322c88.8.1791736075571; 
 Sun, 11 Oct 2026 09:27:55 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becf08sm25001242c88.5.2026.10.11.09.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:27:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peterx@redhat.com, mjt@tls.msk.ru
Subject: [PATCH v2 0/3] releases: build and run any QEMU release easily!
Date: Sun, 11 Oct 2026 16:27:34 +0000
Message-ID: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cvJ3sna41MWvjhB8H0pIILn0GWhArpco
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfX9ws2zo70GTLN
 5yJSpUm+8wTRltIeaj9qPwIjOrpNKY1u1ARbGPSDpq++6TwYBDQoOuTMD6Md9fhCmFG+il2hbul
 W7tB8o3CbpNkK0KjMuBQ6/Zdr8yAuZA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfXxXCek0KE2cLG
 j5bZ60KWj0UEAYNg6ICuxFJ/NuUh4GDVgcQCtfCff+j7z433Y3/WgAT6s/Bgg6XZwDq7/zvSlLL
 oT5R5z18XlwvkN9mpxeqofn4HT73dYwSPbGAMjNwRg/9ULfkYJFC+o7mZCt7LpujxOiBv/1//Qo
 NRvvHR34P+lTU89N0suncjYOdCg5h7Z6+YFVdA+bVKtV0T4ZDQ3SbmoYcQbHM5rByoP2iMSD1be
 YaEcwPsG1qqA2H9blmfZS1JL/amqpFR6CE4648G1nJnItdZMXtNR7mcYqEalcMJkAEEf6as9F8A
 3TW9J5C0wP7gywRGJZSYt0qKxMumzJ9751/aCvv05S1TtclG2eL+CufJQKP4dWp89iOuR82j5B6
 jkeQ9x4y2Bfi7b/2rPhB9qiFdNyOXDDUv9lkMiyNFBfm23TZxL561pk/CxVtv2a22PG6fBO9Ndr
 FhO6Q4Syz2j0sMVhP3A==
X-Proofpoint-GUID: cvJ3sna41MWvjhB8H0pIILn0GWhArpco
X-Authority-Analysis: v=2.4 cv=asknmiZV c=1 sm=1 tr=0 ts=6acbb90d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4DlUO2TMUbiEHNw8gdkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110065
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

The oldest functional distro we can find nowadays is ubuntu 14.04. Because of
this, the oldest QEMU release we can build is v1.6.1. Previous ones require an
environment we can't get easily today.

Images have the absolute minimal content possible. It's only qemu binaries,
artifacts (roms, keymap, ...), and libraries. There is no shell or any other
tool included. As a result, images have a size from 240MB (v1.6.1) to ~1GB
(v11.0.0).

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

v2
--

- fix generate_release_links.sh: was missing userns option for podman
- dockerfile: cleanup "|| true" and replaced with proper ifs

Pierrick Bouvier (3):
  tests/docker/dockerfiles: add release.docker
  scripts: add build_release_container.sh
  scripts: add generate_release_links.sh

 scripts/build_release_container.sh      | 59 ++++++++++++++++++++
 scripts/generate_release_links.sh       | 71 +++++++++++++++++++++++++
 tests/docker/dockerfiles/release.docker | 69 ++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100755 scripts/build_release_container.sh
 create mode 100755 scripts/generate_release_links.sh
 create mode 100644 tests/docker/dockerfiles/release.docker

-- 
2.43.0


