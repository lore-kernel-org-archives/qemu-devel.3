Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A387CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYMG-0006PL-GC; Fri, 22 May 2026 18:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQYMD-0006PD-TE
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:28:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQYMB-0003kl-U6
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:28:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MKMBi44014811
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BUnBWQRhB4Ou9NxzsQmXrC
 OpaI50nVSwOu++MLFET4o=; b=AAudaLfaPX1AZGw9K+hs0VKDyaG8p7Iz3/vxEN
 DY/AaLDGr4MSexSYJyrRB7G0ar6LyqsbGUK4ZTUzo5KxmrBVvfwyh3PJ8+F/CtuQ
 DSzjjGzvgnyRjKM96a7qQi6EbTQ7MFan8Y9ZbXQXgBRloG0X+jLWFooNokpt+SvD
 x+CeqIsMxEBj1zoi6WMcenPMD3mGpwdM5tck7WqlZ8/PPbtuHfF+K5yo7eJkfNLX
 7xrV4oNaOqFJSFytHkc0jAc5ptyKuxdV9pfWpv3keJYvaYF0OVfm7C/hih/LjG6i
 Z0MGB2I5IRKkotWh9d+bXHWfeZIF3Yo36cGfo95+RCUbZzAQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eax46raf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:28:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304448ab58cso5578463eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779488917; x=1780093717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BUnBWQRhB4Ou9NxzsQmXrCOpaI50nVSwOu++MLFET4o=;
 b=H4sRapYL5p0Dpv3NA9ct20aFwitMtyGBGsY31mYoXEPV12wZkAuVfHM5bwhA5Zc30r
 Jw6V2vudZIXgxlGeqeGh4FPx/Uae7N0654FxoyldMsZrvZn31t9s4hVw0LeM6xKwWp9n
 619GeotrZv5hLerMLzFa38+gflCDqSUdomwM2Gwc3eP7c+QXQJgQVvBL+gKQ6drC9iE3
 IHn/SeHZ+yW1H2QUnEvM7Vbc2YZxPAb8ZkYbXo9DCG6VhmJ6+di8Rz9lg6aTh9PP3GCE
 LL+aJR2m2FsEc1EiYJGgO6CbNMCilh4SsEAdI9o8VqJFRioP9gFgiIJ1myRA59YAD7ry
 3KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779488917; x=1780093717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUnBWQRhB4Ou9NxzsQmXrCOpaI50nVSwOu++MLFET4o=;
 b=LMlj/VeyJElY+2Ztjq1OjiSMW2wyS7zaDMFQVa5bUEjuGIrzC7E72OoRN2ExkBkrwp
 kD2A7r9ozVzHQVygLXggmXVCYMhuqwh+oLa4hfwORCBwLZ6Xba9ImY50SdT/D3eSelPq
 8vnL8pqJrdD6dr5CxcnHjvTsGwqcInaDOH3MNiTyxsxU7T7f1cP5zCUGGkI5+GOxaHVx
 KUzxy/2EaBtaClPGYvMUABcDG78JCxmRx3IR9ZcYohSUMXaZTSzvrylT8vcNMJ1L011O
 K7pKoVnZt6BoFsM+yloHZU+WGIVyikgJBkmvTgTGQgkuaxFs283S5sIvNb2zI6KoiwgS
 kltw==
X-Gm-Message-State: AOJu0Yzp0qZzPkxgFBl/DBnvwPl9+gfYg65zy+N037dtDE0q4X/trRsr
 iAtOS1AUAMKElm8dSvqfqejcRqSOQ00Cffs+ldnHzBufm7gv2kvXVJ1Ik0KG7kQK+ohs/ecC0kI
 OVEoZnbhu/j+5C2ZWrVZlLYfGOKy6PL3JQQqKVTfq+xlbsBbNE3DJPDwapcEpvnllXg==
X-Gm-Gg: Acq92OHE9ZqI85/AxwFJxfYDoPyueJuS07R0EcEP6VMiK8POrhpx7zmyh+osTJNGKaN
 kqQGs44r63VAIPxUZMG3l3zYN6XAFpZZnektA7kckQm82U6ks1IdNhKREG8T87yBn8c7oTrUoN8
 AzEDWzcqkqkjFu3vuAwbc6bpJnfu/SHu3ju6q752R32iyOuQ1uMqWLek8Opm6ifgHwBHjQ0zimL
 ZJ9XN5EiKS0wQLD2AaLt8/S5z+Isu9eSlO8lHBC1tvTCYaDUbHahnkULYKz/Sb7QFxMTPdcogML
 mz17zID6deBA4VPzCSptxlCKTHoN6hMS06odgUEtoKYDQaLcufXVhU64B0t+vRFdSLd+rq49fnR
 fAv7aFat74NiprwPCxhvaOpOuF4DMfsiMmTo5WsOG62gP5UYvpdMgDne83cACWWXdr2DVgA==
X-Received: by 2002:a05:7300:3b06:b0:2fc:9ae6:e5a8 with SMTP id
 5a478bee46e88-304491566d8mr3084639eec.20.1779488916984; 
 Fri, 22 May 2026 15:28:36 -0700 (PDT)
X-Received: by 2002:a05:7300:3b06:b0:2fc:9ae6:e5a8 with SMTP id
 5a478bee46e88-304491566d8mr3084627eec.20.1779488916426; 
 Fri, 22 May 2026 15:28:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f20e71sm1976384eec.12.2026.05.22.15.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:28:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH] MAINTAINERS: update qualcomm git tree URL
Date: Fri, 22 May 2026 15:28:27 -0700
Message-Id: <20260522222827.3239334-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: KlawfkriE_hjDn5tK344dfKY0Wl7D0Bo
X-Proofpoint-GUID: KlawfkriE_hjDn5tK344dfKY0Wl7D0Bo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNCBTYWx0ZWRfX7pkuYXj9bv83
 bQrX+fiQXpo47jvVe5CeN7QqGYaSPGF470IqxDdqpMWdGP0dfYLjbTJehkT44fy1sBa0qgxWCma
 PeLbgoiP1gdE+YrznfL+97qw4JF4jnaJdzbjIhc/vNRtrOKSdHpr/5I/VwOnslQHSb8C95hm2oU
 5qLKCH+pA4O3E3XwblTt1Qb03z3EvbGwVz93DxJAfd1hG+IU9rYmKq0igWzo8pPJ9SJTTCw9Myw
 lU3vHsux89sj42q8wYpeVxgVIknTQ8YUXkuotmLyMjvQeeP4jzO/WTl1O58Oxct7klMbSQot6+Z
 kJQiQxhhi+vIgjREQe0dph0pUO4BFTZrPhvsMrRK3vugAo4AAsqe5uVLulOvDU3Fs0MTGh5FwVw
 8iJBxPQhWJnc+/n7otG2NI9edSbbvX6lsjt8kKST8WJCLHB9R/AO7C0q6SqaY873A6AlHYV661J
 sspqOUJlhyAtsw+mUIA==
X-Authority-Analysis: v=2.4 cv=TtvWQjXh c=1 sm=1 tr=0 ts=6a10d896 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=OQCyZJYWScoE_8PA6FYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGdpdCByZXBvIGhhcyBiZWVuIG1pZ3JhdGVkIHRvIGh0dHBzOi8vZ2l0aHViLmNvbS9xdWFs
Y29tbS9xZW11CgpOb3RlIGFsc28gdGhhdCBmb3Igc29tZSB0aW1lLCBodHRwczovL2dpdGh1Yi5j
b20vcXVpYy9xZW11IHNob3VsZCBjb250aW51ZQp0byByZWRpcmVjdCB0byBodHRwczovL2dpdGh1
Yi5jb20vcXVhbGNvbW0vcWVtdQoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIE1BSU5UQUlORVJTIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5F
UlMgYi9NQUlOVEFJTkVSUwppbmRleCBhOTBkYWYwMzA4OC4uZDlhZmJhNDk1ZDUgMTAwNjQ0Ci0t
LSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0yNTksNyArMjU5LDcgQEAgRjog
ZGlzYXMvaGV4YWdvbi5jCiBGOiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1saW51eC11c2VyL2Rl
ZmF1bHQubWFrCiBGOiBkb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9j
a2VyCiBGOiBnZGJzdHViL2dkYi14bWwvaGV4YWdvbioueG1sCi1UOiBnaXQgaHR0cHM6Ly9naXRo
dWIuY29tL3F1aWMvcWVtdS5naXQgaGV4LW5leHQKK1Q6IGdpdCBodHRwczovL2dpdGh1Yi5jb20v
cXVhbGNvbW0vcWVtdS5naXQgaGV4LW5leHQKIAogSGV4YWdvbiBpZGVmLXBhcnNlcgogTTogQWxl
c3NhbmRybyBEaSBGZWRlcmljbyA8YWxlQHJldi5uZz4KLS0gCjIuMzQuMQoK

