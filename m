Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5691FCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4fL-0005Fq-G3; Tue, 23 Jun 2026 13:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4fD-0005E3-LK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:11:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4fB-0004iW-F1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:11:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBZceR134236
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=52hvFhfxKKD4SgfMU0PSlI
 GwLSaPu6dWK0DC3YKoSgc=; b=E2tgpIxinTOHY/amJxn9tFlz1XR02YI2Bck70C
 H/3HZZsTKxf4+x5fNAF8QmJNWFSSal5Hf4sG9ciXj0wcSy/9w+csQn5qvWOjhIiO
 tlGB411L6W4wV/vezIli/Tq17IRUZtej+OwLhB2RCSd+ZFORrlo/US8Ss4Bc/krb
 0sE4mmio+p7ARfuUeb/8hkl/ZHYyRqt17z3RfAi48USfXU9BJz0xwIpBN0AbojNG
 uWB0sttuOmLqJw/N+ReNUJSJMqGD1iv6clKdEHz5P0nZJQO3KBGsJzL1zme2sJ4R
 N7/3mo5mHfFnOHX2iVi6X90h8ngQjTIzaDr1fo2i1Mo3BtZQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr321rgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:11:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bccca5620so31677eec.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782234707; x=1782839507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=52hvFhfxKKD4SgfMU0PSlIGwLSaPu6dWK0DC3YKoSgc=;
 b=h7hqwQoHGZQ42l/DdiPHOpjLxHISWQw68M6i9KaS6U/WAkNVJAAd7Q1rAXQc46XaTq
 XeRcyeMGEC9kBpwRKaoGTnPDP9mE+zRLJklgrPa7pqcU3C6uiEH/6pWYXQCPO6CAm8hn
 meZskfFgLAyMH1DkBfLboMOZPf+eLvLV9WjoocIgGjaE0rZL16EkhdV0Ctrf2bCsEGOq
 rRH5AkeQzPF3n4RUzBQA8a/HZ8pdaRLn0p+N1izRl1XmxyztLqGup+toKJMG/WMGgRer
 zIstgRjqb3my06QeosjCAPz3+l0O92d4zj2p73j0qNsNvIoTqAR0Z8fr+AQAqY3bwaKH
 WV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782234707; x=1782839507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52hvFhfxKKD4SgfMU0PSlIGwLSaPu6dWK0DC3YKoSgc=;
 b=plJzmg75lMxDRT/QFsjT0v9qIAfPAhdreJOVjPpMFH0/DkRmt6U4/VqRZsMsC9F/5o
 B0KRdrIlRrmrPJlWZweBdqzbvysT1iKq36eyhhzgjp6sVNmBUMwjJTs9bgIxaOrnh1L0
 wjlgt8zP5CGM2BLdTIPYtqKKQc53cahtzKu77jDfL/H6mFc35Z84p4zCeNWS4i0z8Y3Q
 7kAnw5cvyl39xNcmjcq4s/QtpSi8gCq8JUscwmae5F240vuZJp8Wy/f9odcy/1xVY800
 NrxtRrH9lnjMjNhSRlDFTN+ZPMwKXXpPGnitnncXvyKCLCFFkgeT3nD1DS4Jxk8uRlTe
 MQ/w==
X-Gm-Message-State: AOJu0Yz033QMX4wLYbMk+WbJboS+KV3Cd1yiXb12IT7uvFFzu1xU7aqe
 HoGtTrTf9I+6yiEzH3+Uid+Sxm3r8A3CqfzjW8p2VgYLHfGdBK7t4mhQkssh8SVuK9rLabdh3gD
 gz2/wg7Uc+lgG54bYfjOQ/QfRtLzLq1YEJyafsr7oygJoulAEcgKgus+NqdXkCuqGuA==
X-Gm-Gg: AfdE7ck0pbRg27JkXz3bZ1TtpzRk+hwYRuMOnhtsMYm4d9yoE1W5eFLJ8W/Y9X4T4Ng
 12a14cz6O1jQyfQA6M67om1fmhJ8Lm1mW7dcUWfphKAo0O0cBgRUa+fFeLe2Krqv2OgnkpV74zx
 akPabxajOOxU2rX94Z28ey9ZOSfx92cj03kIfpbAdcLo9u5uLn1mZRXBQVSnVC8W1Ct0YheFgvb
 3a1RUst9svrW6ZgV6LgkxGSB6LT4UzaIZ2AEBndfWqUuzWfwTE92z4J3YoxehU/r1J/FQcbUpnk
 r2n+oDz3C2uWCkNUohkZSOB/SmWGIJMawxB8//PzfMc67iHGXswm0j5ycjVxVvSoBShGFXeaQDT
 8lGmWOUT3KTjJOCXe6nrRIhejyX4ce0Sa8ZaFoghT/s0bQ2FWuF2dQKJDrSwPLWhgERomNYd9Vl
 ljqh5K2A==
X-Received: by 2002:a05:7300:6ca7:b0:30c:5a5:df4f with SMTP id
 5a478bee46e88-30c07000e2amr14527574eec.16.1782234706931; 
 Tue, 23 Jun 2026 10:11:46 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca7:b0:30c:5a5:df4f with SMTP id
 5a478bee46e88-30c07000e2amr14527523eec.16.1782234706195; 
 Tue, 23 Jun 2026 10:11:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba5c25csm18186385eec.8.2026.06.23.10.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:11:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] CI update for 2026-06-23
Date: Tue, 23 Jun 2026 10:11:36 -0700
Message-ID: <20260623171137.1847038-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0MSBTYWx0ZWRfX+AUS/CKUGJC2
 txUs5pngjvqpA0b1wbY+02bG2Ka4VIValE7DzPTtvh/PHVnW2JKhQSH4xUEqYrOyx56eKJpR6RS
 pQIGivOVUPKxZTsmXX52PQvA6YCst5U=
X-Proofpoint-ORIG-GUID: yJ9QREO3tHBiHkZct1LtJF_NixAET184
X-Authority-Analysis: v=2.4 cv=HrxG3UTS c=1 sm=1 tr=0 ts=6a3abe54 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=8EPuaJfKnmuSbbOUcscA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0MSBTYWx0ZWRfXwHfGj9vI0PUi
 B2v28qw5SYNf7lxPhFOteZGU9BE4rlllOB9JAkLu6Bi43MFXkt+bDYzz1HswOcjeNticYisEZ5E
 UHBrUOSiJuG8lFe4vxz/BaLi8AKfVDa67V3LhFS23RdojbOlxENSOFxCwxPq5behL7I5dGRTvUn
 S1rhK0yi3BY5dO/UEz3QUwWQ4/I9piFXgRjWD1Hp9gOXeGeaV2Fvw2+X8qDoOyRy4RomkU1p71H
 1UuvFtKdIpoAZ/TLbL/XwohYjC1vq7Ruze8LVKxFhQ38k+Iv/A1dfJaNUq48FAgwXrWOrmjycpD
 6+0JQ17A/q8NeNUvQx4jFC5plEKlvRgmUCMAiXiAUgpsY3E53yQY+Qo8Tf9ffkJieSXi/3ev113
 DPRy3QBGOUSyiMLEdsl3GJooWv6kVx4xTDYU9uz62D+mOofOEPvhbBiHb5YvNThwdlqw1jgssz+
 JktZBUjVQwN8P7Fn1TA==
X-Proofpoint-GUID: yJ9QREO3tHBiHkZct1LtJF_NixAET184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230141
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

The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:

  Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into staging (2026-06-19 15:00:01 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/gitlab_ci-20260623

for you to fetch changes up to 02b5ed7a8eddba8959050d3fa6fa9ed84a9bf666:

  gitlab: disable macOS jobs in forks (2026-06-23 10:10:23 -0700)

----------------------------------------------------------------
Changes:
- [PATCH] gitlab: disable macOS jobs in forks (=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20260610091700.2772973-1-berrange@redhat.com

----------------------------------------------------------------
Daniel P. Berrangé (1):
      gitlab: disable macOS jobs in forks

 .gitlab-ci.d/base.yml              | 5 +++++
 .gitlab-ci.d/macos.yml             | 2 ++
 docs/devel/testing/ci-jobs.rst.inc | 7 +++++++
 3 files changed, 14 insertions(+)

