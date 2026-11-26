Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D2606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Volrc4rQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ht7N/UWN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhuS-0007me-0M; Thu, 26 Nov 2026 17:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhuP-0007kz-5p
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:25:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhuM-0003nB-C3
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:25:40 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwkdi1712686
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8b4aMarPSfDb5Dz1pdkJ4t
 hsoe4UK1n/w1ltgqe+Vks=; b=Volrc4rQhn5QDpuYiHVCru8TFh5mQPirW9YR90
 lwv8ICsJ8Wb4LAGUxIxWYSWfuBzKpOsk4Pk0/RKewYeNHq+mUoDkxjrOVgVDYvTj
 hqil+ZWnA6VOSvJp81iuYgsJ79UZpW7aPOZCsaowB/jcmoUOL9ZJLOJp6eTc2WKG
 VokZmmrS2YFW3uAZGEBT7tZeWQPXCSN/ATL2s638aGiqzTlprYXyLHK//kRdL/sz
 niH66T7KW8e6vOfZGucnbIxKz2ky9A4DFGCOSgUWGkorUbAEEUHRXsEni54nhlAM
 rnHM+JNM+cTXiNOItOQqCECqqJPnx4PWvSoqVqyc7xN6yiSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2quk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e92aad34aso1263750985a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 14:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795731935; x=1796336735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8b4aMarPSfDb5Dz1pdkJ4thsoe4UK1n/w1ltgqe+Vks=;
 b=Ht7N/UWNLl+Xjtd/F8ZQ0th3HT65m/DW263oqToEPO+oGjgI9cypkJjzAs4yJAiaBd
 oNJb6bHaJ17gFON4N4FtMAh1Jl7vzYVWrb8vuTcoTKxhQmZzutckiSYp22xGtI26rH1j
 rGUXKVYOrE9ZDs6erANA1vR8IVo9Y3OEs9gL0fGbstEjpLbj/HRss17YaqGjUD9YVBtd
 qGljp3LTEJ2dVx8Rnhz0JzA9WxDgUbYkiESpvY31V+lNbBiVsdKf2gTmHU/jjw9j/b/U
 KNk4NZu/cGCbYt3agaIoak1DiDddljefT1tcGVIlhbLVh5QqqeDJsD/55aqhc5/MPC0e
 5WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795731935; x=1796336735;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8b4aMarPSfDb5Dz1pdkJ4thsoe4UK1n/w1ltgqe+Vks=;
 b=wPETTjICS8QgubGJhIhfJzhOsptF05/6p9/s9K8UFiKD/jESrDFqHORGmkVNOsOFRU
 OW+48n2iWsbwip1qvegEKixqiZ2liT3RShQzMp2PXyD0Klsat7lYGSXlF2+TcI2uxYrj
 GFTk1q90eNHX93bh5oSiwiamyZjswKTM35/JZKss+CGy67ek99FZpKW3TOprMqUyHgWF
 7HkrQtbpCCwNjuIaU4WYehGfNGlE8sZEL1aQrRCde7XHLEVbgjT1Gx5dJ9NVnujDcPlu
 wydIM9niJj1B5H72rirO4qBHs7845aDkYuQXYV6GpgVUeC91mjpFzgPbG4XkRHF3sSSV
 Rgag==
X-Gm-Message-State: APuU4Z8v/rtNfY8MXS8NFURgExq3Wxk6VseJyNOZbAK6xyjsJ3op+AAO
 3A9MZD0sN1pkG0VH9q99ieOj7I59GLKJSxR78LrSQxd8haqs1/PofEJDjrs8tVoisFthoKwzSPh
 GJh8w3V/XYt6i3Br/qoiI8hZNAJdDns4qMmETcta3Wr9lS3n0r11fHv+zC+2mVMVNtg==
X-Gm-Gg: AZFdTZdhr2L2lWmdzUA3JURbUgsPg7L66qfpRPngrRpeN9N0CpBoFWzGcWq92muPshS
 LkJu91lBiCK0bzjlL6tJpWAkCHL7V3O//1VBgno+5nNimUzbHrSbOrbMU/ihg516ng8/bfGSOVa
 CeaxsnCLLYoZCmG96HMn4yY5AzHdeiP8dINjGllMzM00BjVb6CWlhKilV2E9pFkpbUiSRW5wLTH
 etTCB/yw+rsG6RreHDAYgEXoM5Nm6fz2s58WTRffNcXiG6olhkRNed7en/w6aTmhBt1PdGEHoak
 UKYMltt/Ui8xpi+FyTCwuE7rGg7BUg38W8IRm3FpxDCfAIwJIdny4c2h0Bl/aj5/Dc+BA0YpDUZ
 1jQMI4pc90uYacFb2WYEOpE5p4i2rCkdPdGW3LCgt1pSqGLV6NniyMi5w6k8Er7bvoVwNVD91F/
 dwLGukCdOFpSPnzA==
X-Received: by 2002:a05:620a:45a4:b0:947:1d0a:c89c with SMTP id
 af79cd13be357-949bab49f43mr3957948785a.56.1795731934645; 
 Thu, 26 Nov 2026 14:25:34 -0800 (PST)
X-Received: by 2002:a05:620a:45a4:b0:947:1d0a:c89c with SMTP id
 af79cd13be357-949bab49f43mr3957944585a.56.1795731934188; 
 Thu, 26 Nov 2026 14:25:34 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960068fsm245699905e9.4.2026.11.26.14.25.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 14:25:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/3] accel/tcg: Do not write qemu_icount from seqlock readers
Date: Thu, 26 Nov 2026 23:25:27 +0100
Message-ID: <20261126222530.62175-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08b1df cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VKhtLThsFqOIEzYiiokA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfXwfrcqiAnHQIF
 In3KaOeevlLPeVLBSB9t12tgeaNbAboex7dYPC8rgTO1kIW4SqhADpUs1k/P2dNZ8wJw+B7qE5i
 wAGROIALJbNhKkwvgjEsJ28P82bs2V2ljS1o3H/by8TO1AVcADekBcB/4qhzWSpYg8DisLWP+BN
 o40j22/JibDvwZO9qlz3a99hlqCC4RmOj+f8fOb9eaz2t3wOoXmuxRVbDi/cayMzS3Pg1IBXTn5
 yg7UqmtTb96Ej8ErvtLd45XSMG4q64wqBTKvKDDSd8WEzr6w9i+0HYsj0UilWKBpuIDk4xJzJmY
 E+oYm2NJaIQtWp2v+oFGcgswXn1e2h2idK1WZ0xyMAlyA+OF0N7nXOoGKaQHc10L+6mZIfsakc1
 /LnAfgoev47bn2pFGxhPrTObYElBNzgyiqiSzslKSBFf0iLv9g6kB+vwImB1qDlQOSa3J61Po6M
 tDHtenscGa1E00eaEKg==
X-Proofpoint-GUID: DyBlHzuxXuwUC84S9uSXlaSNAT8XuCYd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfX8V6qdCdhn/+Q
 R30xOjcyy9Bs9MzagHwgJ+IxVN5dzFkZNW/+dPPWyenImJXujHo8q688Qf/+p1Vn0PF1i0inseK
 gmj1dZLYLAh6S1awvCh3cCP9T2kZzCE=
X-Proofpoint-ORIG-GUID: DyBlHzuxXuwUC84S9uSXlaSNAT8XuCYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

icount_get() and icount_get_raw() fold the running vCPU's
executed instructions into qemu_icount inside the seqlock
read section, without holding vm_clock_lock.

In adaptive icount (-icount shift=auto), icount_adjust()
reads qemu_icount twice under the write lock; a vCPU update
landing in between is lost from QEMU_CLOCK_VIRTUAL (up to
0xffff instructions).  Targets reading the clock from a
helper without the BQL can hit it, e.g. the RISC-V
cycle/instret CSRs.
(It is also a prerequisite for reading the Arm generic timer
counters without the BQL, which will follow as distinct series).

First refactor the helpers (patches 1 and 2) then performs the
update under the write lock before reading, so readers never
write (patch 3).

Reproduced on riscv64 'virt' by widening the window with an injected
delay: 7 hits in ~350 adjust windows before, none in 234 after.

Philippe Mathieu-Daudé (3):
  accel/tcg: Factor icount_running_cpu() out
  accel/tcg: Factor icount_to_virtual_ns() out
  accel/tcg: Do not write qemu_icount from seqlock readers

 accel/tcg/icount-common.c | 50 +++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

-- 
2.55.0


