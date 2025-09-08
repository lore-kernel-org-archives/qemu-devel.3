Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208E0CAC585
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 18:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvgc9-00083V-Sy; Mon, 08 Sep 2025 14:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgbs-0007zP-OM
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:29:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgbe-0001Am-8v
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:28:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HFG26002914
 for <qemu-devel@nongnu.org>; Mon, 8 Sep 2025 18:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3EI9SOU6kdd6tgzMd/gX2Y
 zpwNShR+7fPBOkmdAZVfw=; b=Pdj5IbHNLhX9MpvJ/EWnucvI/gz3sSnjIyujHY
 p2P8NM/JDMQ4yzV1nxpzzHu8lNlBCLkBTmBUs/zMGxn1iD+pesGkelDvBuiEEmSV
 ZZs29as9n2PZj/NOVHyOslKabcQxRHFHRoJqU/jS70ZL5m00TPtCrRfKg10G4YDJ
 wvde43c8G1Zm9bUg1Hn0Af3DOcwkZrrzdXaJwDpgcrTK6TV+kgc2BXfhwGBfIgpl
 7nNWCTAIXSC76rLgD0juNgay9nUKUjQ3ER0IRLKKt40LuXUXTQ6ieXCJAK1KmgY7
 R1wDuJm2Q626ta3LOZH+G0Hy669+wvthNYTaVcuEI05hKUiA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kwfv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 18:28:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-774209f46dcso2978286b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 11:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757356116; x=1757960916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3EI9SOU6kdd6tgzMd/gX2YzpwNShR+7fPBOkmdAZVfw=;
 b=qk8DkcSb8N3cSfk4uB62i/sl+x0PUMmzHQz4MA7jNB4Z9vWBI3RqUrcNuW9g14SSlN
 FWM5/FYBtt7g+G/hJQiTiIWnsW6X6GvmJalMFcbYVsXe3ELTUXRfGmhuWj5cKALqHcvN
 XNvrSSstYg58flGHUdDpp5FS5YeehgLTz1MzhYzpR7Qc5HbPTXleXVfRupk4NXeXV22p
 8p3PqeaCi6G8GGlhmoVZRMAeBfabaBk/Q7ejM/iv8OECbIP+zB3R+nJU2UE05TmmuGd9
 DcY6WpufBF5v8JUt1/LIF904424be46YEmFX+S5yIMG7e2fZGIOW5WWifFp6aSaiXuVE
 ZMew==
X-Gm-Message-State: AOJu0YyipA0B3YIOnaFBIzlJMQ9vzfkL+gv8V+HdyIWJYF7rNC63A5pY
 3qcP1LhuCeUnGyUf+BU39HDLModAGmlqtGrLme3VchYgE57Y3aj9/cP6quFi0R2JHPM0zu+PhO0
 qywUJEEyhEWfiEQFAulDzSCuRk8TbIpkeEMcKAcDKVNGfhxDx1FtkkzE0e79/vnlWUnkJ
X-Gm-Gg: ASbGncv2BQdeefy8cM/dd4J8qpxk9gxYieX0VlO9JjQ76BA3BWk/YQoiEggtTr3XnjQ
 VHW0zSbh9xpKdglKCDbQHrSWtQoqUAhoC9HiCiA6PTtWzfiXQ8hHTFbMh6mUqNwwWnXgrb7YuTm
 tF5KDzrgaLYda7gEx/FQY9+SMcII+LRnViMPJ8gcbap/Fy6+I4KjohOz7Nhbd5COqBIElMUfTys
 41e+w3CvNwwRkXPwpO4yo+aawrJEc9oDZc2PqyYIM+Z3hnIcle530jeWR+LosV4SmsvEOi/mtEK
 l/0WwtxFZHYxv54vSZ35tgqkdFh9Jv0DS+dVSbH/y1Km6+BUOU0IOKFRRDVTZ8M3EttFmhPpYM0
 xlHjM9Th1PJq+ux8=
X-Received: by 2002:a05:6a21:6d8a:b0:250:f80d:b34b with SMTP id
 adf61e73a8af0-25335a8eee5mr13716403637.0.1757356116322; 
 Mon, 08 Sep 2025 11:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfO6hEYX1Ke3SCk0TYEZjbxRKZ5qDRbfqV5CHIQoiQ0X8RDepVKeuD8ZWA14cVeWjbq1MxKQ==
X-Received: by 2002:a05:6a21:6d8a:b0:250:f80d:b34b with SMTP id
 adf61e73a8af0-25335a8eee5mr13716362637.0.1757356115863; 
 Mon, 08 Sep 2025 11:28:35 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4f9c35f391sm15480164a12.25.2025.09.08.11.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 11:28:35 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v7 0/3] target/arm: Added support for SME register exposure to
 GDB
Date: Mon,  8 Sep 2025 18:28:31 +0000
Message-Id: <20250908182834.2476277-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXz3N4vj9hMif2
 c7TO/KzKDLC+4hEo6fuoW7kiTzqdcl9RzCZS71baNJqfF9JjbQITKJ8fbDxujJ8rI4H1kT4YTRb
 et/G0K6PbPdub9D6gbmvDJLpcwCgZd0HMmeCyMwv3cf19VepG8D5pVrlF8pDYXjkKUfp/vPm6xs
 H2i/SgcMf0YPDSLIvASs3/zFWqfHGD2Tg4oBV5Q9nweGOBEY086u3TZ2XUPmERDNpj5vsI6iWA2
 QGZs1FHH5QqOshowtIXVO5/2fmKLpLfx5unOJYodwDbaMDvzOE273VF14BE5V687GLiI7mX43Lq
 dOvfFyzywlP/PL6+iHfJpHsX+z+91dxxZqklmwDFgAecbVmeJgvWscP7bPsTnidSrv9KvI4qSPf
 8tTVEAXD
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bf2055 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Q-dapHUw0VXFM7UNezAA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: J6WUydiXtFiafZIS4z5bUrM3Bkv8ByOQ
X-Proofpoint-ORIG-GUID: J6WUydiXtFiafZIS4z5bUrM3Bkv8ByOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch also includes a test case for testing SME register exposure
to GDB, based off of the existing SVE test case for the gdbstub.

Vacha Bhavsar (3):
  target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debugging
  target/arm: Added support for SME register exposure to GDB
  target/arm: Added test case for SME register exposure to GDB

-- 
2.34.1


