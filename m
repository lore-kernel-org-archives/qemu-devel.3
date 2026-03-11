Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C09DFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaG-0001wM-F1; Tue, 10 Mar 2026 23:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZw-0001cv-0i
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZs-0005Df-Py
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3VDYP614061
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=; b=jcqaqlUP/dkfvol8
 KUygFQTCZpJFdJZlG3im0hWm5omCK3SW1FN7BEMCnsp1X5YIhoa234U3tAlJYLqR
 ly1QNZsS5Aw+2F9p3XSKN9PCQbrzE9sKNoC2YR3d/dfWCHzHb2F2/iuL+kDCfBS2
 f95YTtPCnBvQSZOxAZm+7ox5ewciiBJHXMVrA+s9mbbCpVvkiqzEK6RZ/fODAmXf
 2QZzVE69T8+5YG4adAISnbXxqtn7r14ALly9KV/x93DyKDUHoYRYtPw4cWnACVLN
 X4Fw0nFjKdhUyJr3CkfjeR500QS3oxv/SkZPg2qrxj8RH7f7/76Kmgd7xzqi5ehT
 x9sgRw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf01nq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:42 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d74d78c5f7so5574369a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200981; x=1773805781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=WibSCNZVUbk/yiDc8reK3qBP32lpYoa6XF6IQGeiUnoQtDAFYxc0KstPf7nA05OEcC
 Xh3P/GRSRf+m1qcYOT8vbz6EjeUrZkc75j2ZI1+nH4L6wRff7NFHNqyttm9ZmMVCsZDg
 QAftbiP3i4KwStRMV13fZadBcvfTv7nfhOH/cN/wwKbSPLdNmQje4FexWnJToNUq5y9s
 xff/Q+Zb1zLLTUpwqE/rk11gSwQKiHZ1o/JyK40Yels/UzgbwsX+j3e4CQj4kzs++bdl
 BpN2I5dcKD2TTi+VgXHvExrsRHfrOJbQOa1A9VfQRbOd3/M0/oecQ2TDaK/ag0UaPw/p
 4TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200981; x=1773805781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=LklwNoDyRsHQcAmlxX8uKageN+NvhXHJvFtra4vmaaK31bNiURgmc+GmjspGrnzaZg
 a8pRNeITGF/6gfl6JSubKlxN2mPVsxpyHm3vSgQMZWSobJQYVGZQE+pm/Ka1Y+iNMXfv
 I2WXzDPQYeNJxmsjZLsHII2/XTQtEURvI/WEmE/UWL9LBN9mbz8/B+seMtikjW6MlBY0
 10Nj2ejQGp/+4wRlmN7lOe8RuuTVpxxgy2nsfwBGb9jzOJW2wrst5ZH6DgP7LLNMbKmB
 eZYs577V2sxmA8CW7DM+mQvrfiRRkXWt4ZjTdj01O7kskC7k9HyXNVhDg98U67/tGA+Y
 MsfA==
X-Gm-Message-State: AOJu0Yz6Pj4x5zf6OuWqacfY+TgteRCfKtCi+YIAxUbwiEfHqX5c1eLS
 4BQORkY96G3OYxcc3qf+GjYE2OpF1CL5gP5LgfXi4PEGfuWNkCkHEhhf/chvbROIGYJFz8vXN5Z
 Bilkq7x8xyy16IrZjHFk4Zv2RnkLfe+DftEnDBHPhFbkHYCHtqWL0C+giAXEux7rchQ==
X-Gm-Gg: ATEYQzy7qibiwWVmHVNO2RO3AHavDejhbDjbG27w2RBYO0A1VXdpwTZSO+JR2Vm6VDe
 Eh0pZJIYasyJBvWoqxfj3mtp/4+mReA6UtBUekgUDLghS2KKBv6ecLdG2GMXCkMUXg//P1VmH7i
 bWSU6mkg3UzQl+qrqzWJdb1El8R2y83P8gGkxB2k8WJsEKyPHLYgfCbq/t3tSu9KhMhP/+1Jf47
 syZUoAd399QzFqcxrnnCDjN+aFsXPr4VhOwK6UXjoQ266QoPjnPzYOpM6ijswMRWhlDOzSBVaQX
 7d5Cy9Yc9xKT5y0yx31a+CKx+zrwke0fLVZzJgE7FNus+45oATZEmA83P8l+wwj013pCtYrMxCw
 X7VRtZYfq2KwPwzw99AXVO6rENE8QjgV1DcO9ArAxMxzr7JQBctrBlMqZ+coSdOPggzBj+g==
X-Received: by 2002:a05:6830:6f49:b0:7d7:49bc:2dae with SMTP id
 46e09a7af769-7d76b1787bemr856637a34.17.1773200981542; 
 Tue, 10 Mar 2026 20:49:41 -0700 (PDT)
X-Received: by 2002:a05:6830:6f49:b0:7d7:49bc:2dae with SMTP id
 46e09a7af769-7d76b1787bemr856629a34.17.1773200981259; 
 Tue, 10 Mar 2026 20:49:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 10/35] target/hexagon: Add a placeholder fp exception
Date: Tue, 10 Mar 2026 20:48:58 -0700
Message-Id: <20260311034923.1044737-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: XZcD5TBe_XLH7SgHASLG62L1BRMEQg2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX0Z0UdQoxjm/q
 LoEY1Tba8aNnzcWzmQpAdKFddFnAN30ewI7VWb13GnVkBPsBS8tINKEOCxTpE1bRH5KF8c5mzlI
 mRh5olAcwASZ1SDQCmdua9LkbJLWtcuW4HLHs6ANZCeccmuv6F8UfpP9iB5I96e8GfoMSXzH6k7
 sI7lIRs35mK4BvoZBPELn+QhHHdsHIEmWrojm0scwenukGxW245oEoS/xJH38Hpsp0KPcYT4cux
 mVb5dbvY7PMdoxWIFFk4RdbNYHzfSxUHvmkgnL8VRfCilAZrklpzCeG8MxFddlZ7uTJpzIPtqUS
 BekJs/XZwkxOD9gcCLEJLblDEuERijHPUhra8e5kPmul4MsNmUZ2BQUQ+JLnNLZm/hOOpKd7PXr
 LUVr7VPBI4SKXZJd5TVfzayrf017EqlpO0hN7v0CXLox/rXR8TZljCPIW2wQy4KtgUssBBqG1LQ
 +O5qY9zhSBzDwtQAOIg==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b0e656 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=R5LHHePp8dzqxDYlWrYA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XZcD5TBe_XLH7SgHASLG62L1BRMEQg2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

