Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738EDCA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqyfi-0004xC-1P; Tue, 26 Aug 2025 14:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqyfc-0004vL-M1
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:45:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqyfS-0008SB-Nl
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:45:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QDBIlS027928
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ft1bvZmHPBobDPPLyrsgXc
 zNHqnyCMleMRYJ6/kVIuc=; b=Nx+ZARpN08b02ttm7cTltU/Pu9mrmwRPVSX4X8
 ruTNWsyz4EKunhFnbCyE9xnixlvTyHWkxxLBaV17KEBX5D1MhJY3CwkWSAY3IzJL
 crqs8wbq1KMhM0URlyQu/C6Fut9iv60BH+msT1BMurtDzodmSlxbXpQ8bqj+5o2P
 9W6/lt8L2j9wwcM6RBY2CzzJszSUcpy757CPozLRR9+b6PsEkOMZI+k0EO0oUQYa
 wTNrzmPkq+iXrhUUhIIfAVgv0crNjgX0KQeJBYRr0rwz5IuyDG9MV5H5GNAcn4sY
 Twqx9qEhbhhWPwfnlz+ro2dNlc6ijEjIrJPOnGLVAcgRF02w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we1v8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:45:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24458345f5dso66195235ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 11:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756233907; x=1756838707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ft1bvZmHPBobDPPLyrsgXczNHqnyCMleMRYJ6/kVIuc=;
 b=egIM/vPxJmL626VOb+v8yA7VLzpoCSX9BBsvLztqNzcPeOp0GRYQD6BMq9ZpOyKndS
 gtQS7SbM6N2jxHdSMXKdgOK+efuFRy/egRlNJVD0Qj3404QHfEQfEAp9hB9qyTe2iQ+d
 lQLAlXsuf69xB9/yp4Tr0Cd32c8mxNWAxw2MTcoTmB8se9ADOZw04Hm428xlNvr8qVwU
 Of6G6hc3IPS9f/nCRZxkt5iiMbU9w07KLPDIqWhtV9XMpxh4JzPUR3nVLNOnonndxKqi
 UCCK8Q0uP5goX0KBZfR8lAWjktS5X3WDTc1rY5xSEpDsyZ0hnjjbKhEUMzJ4033p8ZP4
 R6tA==
X-Gm-Message-State: AOJu0YyzjvfWboMlzmXB7qfaIZJ/Mwjim0tO8/zvlSWIj1wqo2W5xEdd
 VBgEbMqho5GVqT5EFf0WpVNJDSQgo6MVmYeiXOomaa76++QIOts/89meu7Hp6TBnlr4OQzabgpo
 Uj6/OOGb1cUScyOwUWurBfjrOLaWCvXh5rJWU7+l3KOdGhFw737ogM9M3p65MG3C0FEH3
X-Gm-Gg: ASbGncuZ91t7F7DutTHNmIBKFpmh35GBFkKIOvknbEP8FV4y4AZM+w+CxitxOmzPeIU
 ATmRdBlGIZ5j1Ydd5wOzmTH5ngXHhxYubICFesDXxNf7VOGEBfoMlh2Zz1Ef8mTmchNud7edtY6
 QMAHSSkEROWk+uz8pLn1Zg98FGawygXrCi0MQxDwx9acdco4qAdMBGoWyvQXvaTSOhQHOYnwWIl
 LI7SFbmOHjXsCt8HN1nrfGJEeI9Jx88LfTY5tgu36OlyPXTnqyg/sXbaXIpu6nxMkcvxOBwYEeS
 Vsnn1bbPm0+GaRAk485RfzIMUsDVKuVB8h7Lbz4zdyosf8ucl9awN5MgGrrSSHzAfaDuwj7Lq6d
 yp6EY9hC8hFZcRX4=
X-Received: by 2002:a17:902:db0a:b0:246:f123:ccdd with SMTP id
 d9443c01a7336-246f123d18dmr69962415ad.8.1756233907536; 
 Tue, 26 Aug 2025 11:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDOo5r93vkmUGAMUNW9HqJvEK5kRGRkTf1jBKq9I+6F7uvwRBgpBLR1200yKu7ZRAybbuxYQ==
X-Received: by 2002:a17:902:db0a:b0:246:f123:ccdd with SMTP id
 d9443c01a7336-246f123d18dmr69962105ad.8.1756233907077; 
 Tue, 26 Aug 2025 11:45:07 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3276aeef8b8sm220661a91.21.2025.08.26.11.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 11:45:06 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v6 0/3] target/arm: Added support for SME register exposure to
 GDB
Date: Tue, 26 Aug 2025 18:45:01 +0000
Message-Id: <20250826184504.510279-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nWXdroHsVUuYC1Cu4Du0Ju4avNSQ2zIF
X-Proofpoint-ORIG-GUID: nWXdroHsVUuYC1Cu4Du0Ju4avNSQ2zIF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX8uAAFgDcSkc3
 ZvPK5Mox9aSyV65gf/yHRCjisLEKaF6j6zq+9bg/hsAm+RwDd8zHtH7D5pLffkcgSVJ0k9VJTt4
 qR6PSLuI7Nj67tVTwCFA6tcd7jc3vzHxp/3HAVYvcuqIxH/wCX2q/nXgPi7hN8h84DAlXqMJzHi
 y2Y1xeFsXLMYbcW3uvg3ppL7nJqWEMpecfWQxCWvhlDFtYFdSiEKpHhqB4E9RST48H+5wWkwxMB
 Enqm7OmNXQvM+kJ91+mxmYOjHFC4gm+OtYpHnNg+zD31L98e4z1J/l7KFO75yps3CyhbtLS/k+3
 wmpPzDWcnFmIYxqt5eb+TgTus6k72JItSJD0fW5vWFIsGy5PQmSI8K7+eeJ0Do9nKstZ09WtzyD
 0GEYy3k7
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ae00b5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Q-dapHUw0VXFM7UNezAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QEMU GDB stub does not expose the ZA storage SME register to GDB via
the remote serial protocol, which can be a useful functionality to debug SME
code. To provide this functionality in Aarch64 target, this patch registers the
SME register set with the GDB stub. To do so, this patch implements the
aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
specify how to get and set the SME registers, and the
arm_gen_dynamic_smereg_feature() function to generate the target
description in XML format to indicate the target architecture supports SME.
Finally, this patch includes a dyn_smereg_feature structure to hold this
GDB XML description of the SME registers for each CPU.

Additionally, this patch series increases the value of MAX_PACKET_LENGTH
to allow for remote GDB debugging of the ZA register when the vector
length is maximal.

We have chosen to drop the patch related to changing GDBState's line_buf
to a dynamically re-sizeable GString for the time being.

This patch now also includes a test case for testing SME register exposure
to GDB, based off of the existing SVE test case for the gdbstub.

Vacha Bhavsar (3):
  target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debugging
  target/arm: Added support for SME register exposure to GDB
  target/arm: Added test case for SME register exposure to GDB

-- 
2.34.1


