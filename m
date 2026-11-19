Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62F606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lw2jTx2y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EGSWBgJG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBef-0004SZ-RC; Thu, 19 Nov 2026 18:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBed-0004Rx-SR
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:34:59 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBeb-0008Vo-R0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:34:59 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1kT53148674
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qyGxea7CZMdHr9oNzct/cS
 WVxhdPiMdEpB3uAjom24Q=; b=Lw2jTx2yntHZF50SUde1nCl0b9jGZvSynw0PDU
 sWnclaaoJPCkUYNTCmEbY3ulhJH3JjvrsdUMbnJiNKjXtYmO9h5lovgq1kfEW9JN
 o6Xhdd476+GoUs3TYQ+/s0iWO4D0YozTpjyPkYNFqD/3Xio0p1Vk4E/XM0YcU5Qv
 K6N4iRrTnuu5Lws9yeeRDayNVbCriHmpjQk5T8i3Rv+oTxRsb0C4vbaLYdlwYW2+
 8LaM1WvGoe5bSsWoUOCcTQ4TgecioSGCqfhD+kgru9Lq46MOVrKbi2c28fgPN9bB
 Ul8t9pxf+va8uBufSE3bMXNBNYCVb7fH2PEwIsJh9gNokkbQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6bag6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:34:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d3232fso58226085a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795131295; x=1795736095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qyGxea7CZMdHr9oNzct/cSWVxhdPiMdEpB3uAjom24Q=;
 b=EGSWBgJGcBZTBI3c2jX5gTjnOTWEHqYL2lXTcqaH43gPA0ZRPn/cZKr5sVO8tzeQIh
 MiG/KYtow+E/hJn7VZenupuAJZop1y1V0QRtovDyNSNplMLHlqOLgTW774f9Q2AJiUlF
 4FhWq0ECn81ncJmyZ0tfHrCp36o9CgupsvVrJ6ZUUNGHggS0KYvh05QJ8et5MnkH1KA4
 ZJ3D3Q0DI2cGpjDszAHqpI2pADYW553bPLn4a6tPhJCN+zGVBmexkcBu10Jlf/NQV5N2
 sjGRud8JbTCVvNBpK6T/ufNmSmEV0E9sc/3PtjITtu9sQ2toUC2u4cag9emqhl9H9Hi3
 E2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131295; x=1795736095;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qyGxea7CZMdHr9oNzct/cSWVxhdPiMdEpB3uAjom24Q=;
 b=C3aynzDQR57Fo2HoOJIjlgsVZhZmi90pFr0+Vo6iP8rWAX8h/nRZCcyyPwl0DVjtX+
 cleIGQvQh0lKT6XNE/39kFuBnCdYNBF9qrjlgh0/hpT/hNXLiJ/K464QCOgLJCdl7OmQ
 P/4OoxkoKYDqbIQn7OpLWYhXiMKDSQ4S2Y8AMpCBNikVIaN39JdmwXQ3pY+y2HaVMYbs
 GDxg71jtIr47mqKAf8WIp13/CLCue+8dGbYTuBDLskfbXCZHz6hlY6tGo8IYWf0xdQuJ
 EJ54L3OpLyPSHlfWBWyUr7Kj0dHdnGk+vTBxDAOj97cg3XjOvNHNWdh35YH7mPtH35rI
 4dZQ==
X-Gm-Message-State: APuU4Z8nYredydpySlBD0YnwnJx8ROhOVSIuRIgGOvZA4IdhkOUgaL0E
 aq6t1dnKk2QiPbuplYLUf87JGyePay8H4BWcXFXlv16Yk8DTwUAP/Z3ogaUAUjPFIlIjQtF/13v
 17gTLQy6KyTIR43uW5BXzYC8iD/rOzKZQQ4HA7pygY1BBd9Fs3n7jO0TkEl/S0Fx5zTLF
X-Gm-Gg: AYBFou2Eli1gHELJfen6ju4CrGUqJNcYVRf3SMdJisY65DdIyg41jPLph53u4NKpt1d
 sx+0y+DHI82CUZhUfvpqE4W4W6eTdZ8aiFL9LE8kEKkAi26Pg2XdxARKJTnzsgD3IGSvWMEWIPH
 PHy0Dxi6pFq8uA+Lrdg/9Zm2VGHqW4iYRt+obpXKSb8XsBo49fPwvTKivOWb12cgRclyb99lY4X
 xX2GTa2FCZqQFoS97nJqNk2Hp+xq+cXydyiHiSLAeTx6PJ+kV52WIjbB8+3PjR4EOXgxb6wROTq
 NI323aAdAeEWfA0BzT3pdkbKHnYM9TyrjZ5l6VP0UESjcQU1YbMr2J4U1ngai3QIQk5bQgNpnS8
 fE+042zb4Vex5kLaSNxct/tgVr+I3S5YicteZSMBndjyu36ntcMwWYbuCaGJ6dadZrXj8ZtZks4
 lLwjL9JiD06GOTkw==
X-Received: by 2002:a05:620a:2906:b0:93c:5c60:c3bb with SMTP id
 af79cd13be357-949bab65d38mr229162385a.62.1795131294684; 
 Thu, 19 Nov 2026 15:34:54 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:93c:5c60:c3bb with SMTP id
 af79cd13be357-949bab65d38mr229158785a.62.1795131294284; 
 Thu, 19 Nov 2026 15:34:54 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm30855065e9.12.2026.11.19.15.34.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 15:34:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH 0/2] util/qemu-timer: Honor sub-ms poll timeouts on Darwin
Date: Fri, 20 Nov 2026 00:34:49 +0100
Message-ID: <20261119233451.47453-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4OPL69ga58AJV9HQSBRYr090qgktUirS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX30yvBfhrA0X5
 tdd+vdZqJ75VqikYk6DYeI4rmbhg6AVWYrRBN3aOGyBKQKj7FCEztzHSGrUzNka5Is62x5htc1j
 yjjAdARUn57jBUsYOLhBUstjJ14MUX4=
X-Proofpoint-ORIG-GUID: 4OPL69ga58AJV9HQSBRYr090qgktUirS
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6aff879f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ql-Ryi9I_HQR0uBmDssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX/l5SahkEajjG
 T0i71D38ektiIxyqwyY6E+ABMCMqzDKvqI8fmZY0j58SqF+OJsYRtMqEBkMdtgPg4DF9jiHMeAo
 Si8L6nc+MZ2aPCpj7AzcXWDoww7tAtUqmI2hBwi8LfvOH/IcqGbQpvd1pW46B29f2PV0prxbkfZ
 y7tIk85FjxK6JDHp4qUUWcD/Q1txKThzbgnvScUQPf1FNMKzPfaFrFH96+2sHNgmysc+86VFsEH
 pbD9pUqWMnL/LsdyEkG6FNhg/Gi8qb9OY9KNEYU+xUzbG7uP8t42X41+LTW+gEBulJIUFZvz+J0
 2gnDgeuTy/8aCy0od/fA2fI75Ayyyb0P6FsFJ5ZYD4XT26diQPeux778s5XSMf6TYABV5wcIt7U
 Tv+e+2BA7ZvZ3AXTVoGqVMXnNEV6kLWc9w40/CuPzZY4tecxYmhFLHcgijGNbDqYkyyhvXe9bBr
 bKySdAA3r0Jzj23cQGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series corrects a long-standing platform limitation:
qemu_poll_ns() promises nanosecond timeouts, but Darwin’s
g_poll() fallback rounds up to milliseconds, making sub-ms
virtual timers fire late. Fixes the observable behavior.

Add a Darwin-only microbenchmark used to compare wait
primitives and justify the chosen approach.

During the final sub-ms sleep, descriptors are not polled,
so fd readiness can be delayed by up to <1 ms. This is still
much better than whole-ms timer overshoot and avoids busy-waiting.

Philippe Mathieu-Daudé (2):
  tests/bench: Add macos-pollbench
  util/qemu-timer: Honor sub-ms poll timeouts on Darwin

 tests/bench/macos-pollbench.c | 290 ++++++++++++++++++++++++++++++++++
 util/qemu-timer.c             |  27 ++++
 tests/bench/meson.build       |   6 +
 3 files changed, 323 insertions(+)
 create mode 100644 tests/bench/macos-pollbench.c

-- 
2.55.0


