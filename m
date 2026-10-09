Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB8ECA6018
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEyp3-0004Ej-TF; Thu, 08 Oct 2026 20:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEyos-0004DA-HO
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:50:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEyop-0003fT-3O
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:50:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990Pvhh1348603
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 00:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7S17So41dZKXCLqI0ubdd3
 siyx/Q79XJ6H9LVz8gctM=; b=WY5pu/Ywwe5Iqm19cyo1EPeSfOcndi4LQldRqU
 B4RSy/RSNKFzb+MNL3492GcNfPV55BWqJxw5mdyaEx6bJPyF1tKF7k03bZxXHO8K
 l1TASzrM5zVCzjubt+blhSBa7oy2kNwU5qHNwxvm+hMGMElMBjrget1E/27nsc06
 tTuZHXbJ2AKe7Euk3Dd2TscvKvPXU0arP480BnkRZFxCPcYUqyVH5QFFOoNAvsX3
 0g+RIcRfJ+ARxaSvG+mMXAdafyTK6voXDr31oThQlkWt0qelKQmngpuzrA3YmQOz
 LcDxFafZ9D+oNtNvehJ55UDBAuABFsFooogU2ZQh5uObYn3g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxw97wk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:50:35 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so2223606c88.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 17:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791507035; x=1792111835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7S17So41dZKXCLqI0ubdd3siyx/Q79XJ6H9LVz8gctM=;
 b=jEUiQF4G0fxv0U/WfPiHLS3XHjk8wdirArkqDq5AJ7LQHM05YR7iTREqaHeXSADKfa
 htOoPyqTJ7UpmNC5rJE3OrpLQq9PEJgrNf6JMclX2a1MyRxczMF6f2rwdeyrqlIE5HMP
 ncKiCtBKRfTk5YmGpBVF0PUXn/XWLs5CMV9+SQwM1PFT/7NnU6bN7Rs9I36hGLNIcbzr
 LRTHaDJVpjK5eIbUZFM5yROyGWo9ClLiHZibdPkh5SKnjfcPiYeAn4/dlZId3QWXIeYy
 0m95WCV90BUfmE0iTgSXIGiCtxiayuJg633HFaETF3NYtazXugEEvsxXz1Op/M5E5ebN
 OgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791507035; x=1792111835;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7S17So41dZKXCLqI0ubdd3siyx/Q79XJ6H9LVz8gctM=;
 b=oSkx320RlQxphuXjITryaXW9795KSvWmHgYDpFlrmDlRlV+iAnkAX+AbI8aS3gTvto
 GSKVcAQ1ULCQq8BwsUaCZcfYJEgIisQWGLn6l2aYYEbWCG/EEtE+W3UF7UWKMmCz6o1A
 5oGK8IBezNnB5xlsddOBQfStJM+U+KM8fXOLelpv8MTjP67Db1+2boL2pA3SmOdI5oXN
 88iRkRa9oHuL5hjYrvKuHqFgOTw3VcwO+h3ZmEhs/+OZDy+LKA7UcQ3Xkbd6dNMa5g2N
 kGCv3zyrN1XSqJdOborv3GUO8k9LsVHoieVf+VuSu35HAPdtc9EN2tVAFXVZD77b977a
 A+ZA==
X-Gm-Message-State: AFuF++kGSvLeOULfAqG47SQTWiiFNzzSzvbjFNlehs6bzJPnVpmBmM4Q
 xEOsE+mKJM0WU0UzGvJe0l3o7eudCdh8aJVa5DDmgrdADuERHDoNLVATb6tCgduXvFtOL9emtbX
 VeLW/wjFeTM4TpaQRZLElo7bv5Sk0nppxQOVao8I2axaT3a8KYqNrjmDZL1xUph2diQ==
X-Gm-Gg: AYBFou22LZsSJa0XSBkyA4ydan2E/Xb7qap7Utn0p5SjflaUNO2PN2NLQ43fLfPmk8z
 WelNeQpBFUcHiZTyYzSYRQ9s0b3liCIIGsXNI0hry19SU2JpXdFKZiErbEI4gzKN1eqV27ED5ZE
 iUaS9853dPbcd1tbZ7/wkeqK/wlwd2jdvY4em3bqYnxoDXtUUbVi1K3OPm/7XffnBywyU+IYPI9
 1PpbYN62KDJc4kGmb3leWdHTQM/iCEnHz3ib7w7CzQaDuBFV+Rd/29qTX89d5vyfgbX9DMSLysc
 SLGTMh0HXhign2peT0X6QemLF/vlPBKlh3xqybXyUbefmJ3bVWMucuo6jTCtQIZMkufr37oYK0u
 b7hJqmKBflAKptx+v22afCQ1muirid07fPfgrjiuF3giXtOPo3vZ+ZUmvmRld
X-Received: by 2002:a05:701b:2512:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-16a6250bc3emr385783c88.32.1791507034655; 
 Thu, 08 Oct 2026 17:50:34 -0700 (PDT)
X-Received: by 2002:a05:701b:2512:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-16a6250bc3emr385756c88.32.1791507034041; 
 Thu, 08 Oct 2026 17:50:34 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a4429603sm1604616c88.17.2026.10.08.17.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 17:50:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] Build fix 20261008
Date: Fri,  9 Oct 2026 00:50:15 +0000
Message-ID: <20261009005017.61989-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfX1seZDBoFn+Qt
 /LAUxud0K7r5/h3ZB9YT1AaXmts/ibOnKgFtTjB0CyAhh2SzVG7STzQMNesAuNFdO2hbbM3piFP
 IvrJ/QzD5lZVEx5gjUzrJ9YClXB3hlFOvuNnvFmooPLhqO9cptikBpWdkx9nznuffXgmB/ETYco
 9zcSzMGVinAVpTOEeTo6V5bzRFSafq0zw6dfn+WoC0PyOFvVlED5utvNd5zvLCYXkVMnIv28AvE
 2MXToM3UeVFBf+WRPGlrvCoeDeXLAn0a0J+E442snKQOkSMkubPDiKoCzJhbEcRRIKgdtyrximn
 uqep7RM7i+PMAE1C9Q9eNvKxsUMIoUstyi/0q6ePVaHzbPPiBUHVUpcMH3/TzW45H7gEHbGeYUQ
 lNfVpRhPj76hk1rWZ3JOkS0Oc847SvMJQliTn4TIWIOoFgKQk+BXEoUZIv7bqZddNtKL7dYF4tk
 DN5Vvyf4Rj0rYvb/i3Q==
X-Proofpoint-GUID: K0hL1RcVQd1smmf89rrYgGFq0Hro4BIh
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac83a5b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=dM0neqjTbBrA9FJYkHsA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfXy/qyukf8QgTG
 PMYlZa9WYEYbjGc7eeYVmX/IoMbDY3Y+KGyszN12KWuHIO4e+tF0/6x/qd63QdwJy5yT0iAN211
 fHS6HPqcD7FnoeWhoWa/gWGF8l6JePU=
X-Proofpoint-ORIG-GUID: K0hL1RcVQd1smmf89rrYgGFq0Hro4BIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:

  Merge tag 'pbouvier/pr/plugins-20261005' of https://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_tests-20261009

for you to fetch changes up to 39dc3b12f6ec1aef0ed2df761735c1fddfa7c779:

  gitlab-ci: enable slirp in the Windows cross-build (2026-10-08 20:58:30 +0000)

----------------------------------------------------------------
Changes:
- [PATCH 0/2] tests/qtest: fix and gaurd PXE test build on MinGW (Yonggang Luo <luoyonggang@gmail.com>)
  Link: https://lore.kernel.org/qemu-devel/20261008184119.142-1-luoyonggang@gmail.com

----------------------------------------------------------------
Yonggang Luo (2):
      tests/qtest: fix PXE test build on MinGW
      gitlab-ci: enable slirp in the Windows cross-build

 .gitlab-ci.d/crossbuilds.yml |  2 +-
 tests/qtest/pxe-test.c       | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

