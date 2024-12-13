Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E33E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 04:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLx8o-0006a2-8x; Thu, 12 Dec 2024 23:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8n-0006Zk-BT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:19:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8k-00082h-Ek
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:19:01 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCKpm8B030100
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zQvZiKgrtXs8Zu4Ms6Zmq72hJ9m6gqm2Cz2XsblQju4=; b=linaUZdR7idJteMc
 NnXVvMN9gMgsUcGefhTv5AzQ/UB/DZYhUT2qN9hFOt5uV1o1inbGgG6ejIwdrAOb
 CErOgryn2coZjPQ/1A3mmAWJQ22M4rZtEHyKwUeCwEXgw4ywzPRF7P8TRQuphCok
 /Ft14tq6QPR42mpTO24SiX7I80vhMmLnZkzL2bygBqE5ey4ahWAMXU4BX9lA7C6q
 OFx9UM4GKZMgkoK+PmFpDzaGzf91lSMPDgdibjTlMbvZTIp2FFb+S7CykeqiodIr
 EHYGmeGqzLvbUPaV6fyHP31IzpNv3U4AE7FxFxmNZp+UyXY7tvtdV7tHlb/MrCUV
 nKMBlw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fwgejhed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-728e3ae8112so1153973b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 20:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734063536; x=1734668336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQvZiKgrtXs8Zu4Ms6Zmq72hJ9m6gqm2Cz2XsblQju4=;
 b=v/Ax25qnlW2uMuiu0ecKXarzr54Bvk1rMsoeJQQtbhwBwbsDeDm7rxLFim/AUjq7+K
 DoAaLpYz+Y88WQ9KGGrjquux7UjXLVFs5nxuNI66s6gyA6/7iwp8++qXI0ffC6VivhB7
 VpW7D0IojZnIAOEkKvOdqs054Z30Ue+Q6Ou7292hK4nzKidl52QnVzdeE8Dq5kBR7SDC
 LXJX5HA1tr2uZ5DcJ2T5GI5XkEFh9Eg6VXZ1VeWwCpd+StNNDm1QHMn+FUpD3GKi1eP2
 HEP/UTKACYk7b15wxh6JRctHjpjZJslPCrDtPrEObc9cf1jtf/j1TAkTmAladk75sKNp
 C/GQ==
X-Gm-Message-State: AOJu0Yxwu9scRr+lW84xfb+SsDTui7jsIV2D2z9hq7n8+dh3ZyYahg2a
 onFegZ7LnbX96euB4895BHBvMlomyV6pEGPIi0pWIgAAw6sb9vdVCsvTOzogr5lMbS6uMxhzJCW
 Hu9pUN/GHOgoEDBeUsfOjNGnz6wUy28jHGvK+13XLlS/GtJ0O/Ny9/uekYJrNXQ==
X-Gm-Gg: ASbGncvTL6LOuXmaXlF1TMm2AG72Z3CHuvZdjhcY3TfpuFhTuOOlml2qaQv47Vk72xh
 x/jZgDL1FtvSbOa/CU5uU8ex8/95hjX/sGaqDpyU+kQzPbcOomVpfvDbZu6wkDNmP8p1YV6qLkn
 JgpqXraBlFmjgfDkJl8VIVuJ7ipWtS/9aET7UAnBMBJxHRwvng0eTWu7OXN7E4+R5kJnFLgDzxi
 TZVXebdzTBSNNFdhy0bBGSJjXNrrxxBDzz7Ycc77P43xDhuyeQEbYSh2YQfGgxQoc5JGRNhhaVf
 9NZjaGDPuBkvAAZPengZLngC1NxOXA==
X-Received: by 2002:a05:6a21:33a2:b0:1e1:a9c1:b343 with SMTP id
 adf61e73a8af0-1e1dfe43d95mr1575512637.43.1734063535680; 
 Thu, 12 Dec 2024 20:18:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAHDQu6qQ7EmLoOtLLufIRBn/4+WmF5qtMo8GhqmkLOy/J6BXIQwgkc0BgLHCnZ5F2NrbfRg==
X-Received: by 2002:a05:6a21:33a2:b0:1e1:a9c1:b343 with SMTP id
 adf61e73a8af0-1e1dfe43d95mr1575492637.43.1734063535286; 
 Thu, 12 Dec 2024 20:18:55 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725deac1daasm9451938b3a.171.2024.12.12.20.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 20:18:54 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, peter.maydell@linaro.org, 
 quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 Brian Cain <bcain@quicinc.com>, Brian Cain <bcain@oss.qualcomm.com>
Subject: [PULL 3/5] target/hexagon: add enums for event, cause
Date: Thu, 12 Dec 2024 20:18:34 -0800
Message-Id: <20241213041836.39986-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
References: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Q_gO9pCbQD8qaMPAk9dXUPLzUVU2Fx0O
X-Proofpoint-ORIG-GUID: Q_gO9pCbQD8qaMPAk9dXUPLzUVU2Fx0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=852 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9iaXRzLmggfCAyMiArKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9jcHVfYml0cy5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAppbmRleCAyZTYwYzBmYWZl
Li5mZjU5NmUyYTk0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCisrKyBi
L3RhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmgKQEAgLTIzLDE1ICsyMywyMSBAQAogI2RlZmluZSBQ
Q0FMSUdOIDQKICNkZWZpbmUgUENBTElHTl9NQVNLIChQQ0FMSUdOIC0gMSkKIAotI2RlZmluZSBI
RVhfRVZFTlRfVFJBUDAgICAgICAgICAgIDB4MDA4CitlbnVtIGhleF9ldmVudCB7CisgICAgSEVY
X0VWRU5UX05PTkUgICAgICAgICAgID0gLTEsCisgICAgSEVYX0VWRU5UX1RSQVAwICAgICAgICAg
ID0gIDB4MDA4LAorfTsKIAotI2RlZmluZSBIRVhfQ0FVU0VfVFJBUDAgICAgICAgICAgIDB4MTcy
Ci0jZGVmaW5lIEhFWF9DQVVTRV9GRVRDSF9OT19VUEFHRSAgMHgwMTIKLSNkZWZpbmUgSEVYX0NB
VVNFX0lOVkFMSURfUEFDS0VUICAweDAxNQotI2RlZmluZSBIRVhfQ0FVU0VfSU5WQUxJRF9PUENP
REUgIDB4MDE1Ci0jZGVmaW5lIEhFWF9DQVVTRV9QQ19OT1RfQUxJR05FRCAgMHgwMWUKLSNkZWZp
bmUgSEVYX0NBVVNFX1BSSVZfTk9fVVJFQUQgICAweDAyNAotI2RlZmluZSBIRVhfQ0FVU0VfUFJJ
Vl9OT19VV1JJVEUgIDB4MDI1CitlbnVtIGhleF9jYXVzZSB7CisgICAgSEVYX0NBVVNFX05PTkUg
PSAtMSwKKyAgICBIRVhfQ0FVU0VfVFJBUDAgPSAweDE3MiwKKyAgICBIRVhfQ0FVU0VfRkVUQ0hf
Tk9fVVBBR0UgPSAgMHgwMTIsCisgICAgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUID0gIDB4MDE1
LAorICAgIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSA9ICAweDAxNSwKKyAgICBIRVhfQ0FVU0Vf
UENfTk9UX0FMSUdORUQgPSAgMHgwMWUsCisgICAgSEVYX0NBVVNFX1BSSVZfTk9fVVJFQUQgID0g
IDB4MDI0LAorICAgIEhFWF9DQVVTRV9QUklWX05PX1VXUklURSA9ICAweDAyNSwKK307CiAKICNk
ZWZpbmUgUEFDS0VUX1dPUkRTX01BWCAgICAgICAgIDQKIAotLSAKMi4zNC4xCgo=

