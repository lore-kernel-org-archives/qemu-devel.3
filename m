Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE3FC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlwIk-0003yR-3m; Mon, 20 Jul 2026 18:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwIj-0003yF-Ca
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:17:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwIh-0003a7-70
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:17:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTxrd3368777
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=k4rAdVqaiAp5XA86sPo3qo
 wQ5nqDHEXiYgOhRbLG0jM=; b=PpetJzJb787bYYtVIZ1iTmMOxNXtOQ+NgETzUG
 9+Y5FKndYfBzqeFVCEVYiu9j3UK5GpMX8qfPqtahw3ELeLgw/KUweEijwitpf6d3
 upTEZD2MrzZ5TQgt5EHg3Xj6efIBLjjEFS1dSN46/qgtfNa+Djf292+bdih73MT5
 KsAKG3wGcm2+tc2E6vtJXmwN2/czJ7CMIfDFvg1vyajdMZ/UNAD/LB5FsKmBqB7y
 a/FQKev+bkOMoQM4APpniqDzoa8wwpPw5gmUKXQ8G6m0y4eMhCty25lV8NoumjUp
 6NdTi8vO0U8DSl6HBoM89PXaj/tin2P3c792rbiMCCgpdwhg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs038hb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:17:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so3579251a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784585844; x=1785190644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k4rAdVqaiAp5XA86sPo3qowQ5nqDHEXiYgOhRbLG0jM=;
 b=Ka7bpKvc3ans3kMXBz4zmicom9HhGZCGthECFdoYtMWDzlh6BCLg1gGxajTtsKJeCo
 vwA16Os9Om7FcVrBuZg6cIIVzVNdFs5FnCnVwC82oDz9+EMJ5QO1Ndg3cj0gPzZPP05F
 BIJpUJzkNGq9CtsvPnSznaHhnrInSlS8xfD8501K9Wq+aRqXYZiabArhWNUU+m/Hd/Xg
 zv2fbxFFn0tMpGCYRS3db8HQB1nyJm7xYMbNPgfVTuSryG050Td9lK8DlGn5Kio2QSpY
 yUffncxj5KRBcRAnuNGQA1RvneJI/FeB6wlwDM37nf+oCxzEYljhkcn2HYIaj291izRo
 QHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784585844; x=1785190644;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k4rAdVqaiAp5XA86sPo3qowQ5nqDHEXiYgOhRbLG0jM=;
 b=NzKHYOhMOxV+qkA6Y4Ftnz7FAFCdqo1yQnWdDm3AN7bYlYjqwd+eLxpW6X8hm9ip7d
 ON6CZDophnoHl6Ld/cyp0Dtxc/7k649hDlZDpoxNH0Cmc72FhwH3PZoFkk2e+K/BMrGw
 9gtouSPCsPJvgwrQ593qZSOLblqMR6mE/KquYB9Sa+Uk+frdSc98pOk9RdPiuhGdRylz
 klamGck08PNjMwXPkvrm+9a4h6SmF31CdPi4pisS4zkPcYbkZOcQ+QZeQt/XL/u0QzU+
 M58BUvkp5Nm2BiBgMwbl+A9XL6Ifnd9lpNzm6M7a30S8REBTZtcg4GhrkBt0/mBP48FH
 vgPA==
X-Gm-Message-State: AOJu0Yya8rCOOZNPSgYPEGiCLct4ldR77AwHdxUDSwrZ4NjipgQxkZdw
 zmZB0dOW8jEt115Ig719Kkz11r+OIDsGZwSJ/ZOp17FoxJNIVHKVEuDh+ZjiQsZVIBdDM+3xLpx
 6NBCcA8WG6/70XfloIj+kP8YwvVACa9kFc29Tf2gDq0nHrHeUcYWV9c5F6MIHMnppNw==
X-Gm-Gg: AR+sD1228e0pzFZtmj4dkIo/WMdk3kHP1s9I2s0euJYbU003yIf1J5ItyhEoYMJ/F1I
 cwnTzO4hOYN44OZU480dTSGkjTgTdSyqkYxp9ZYWBKsrUeTe7wDG0xmoM7PrcLDMCXOQuqDdIY3
 ICBeFXGEPbeJqI8+KNkiQi7hnm737UXgZIuaZabOUS/JlxOXx1aWQZGvQlpeoO9WTPLA+gSHcbI
 yfBGii7YYz3sLu08n9vib3ZXFUN/X9f/2keJLrEazAeYqwGsON9OxirVN+OYhEXNtjm7noFKr5y
 zS5vwH6YVnF37DutIeS7DbUfxdHfalpcD22tjYoy+/zbzFyRRIJCRa4es6qfRz92m0XodsytLmX
 j8eeeycNppv6SqHTUISLNe2ErjlajsGj26VF6E7dYsowwdQ0++gNtgJ5DkVP5DT72g41Bu7g=
X-Received: by 2002:a17:90b:41:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-38e4b54614cmr16515780a91.23.1784585843841; 
 Mon, 20 Jul 2026 15:17:23 -0700 (PDT)
X-Received: by 2002:a17:90b:41:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-38e4b54614cmr16515750a91.23.1784585843390; 
 Mon, 20 Jul 2026 15:17:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cd6e6esm33855000c88.13.2026.07.20.15.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:17:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] build: fix sparc64 host
Date: Mon, 20 Jul 2026 22:17:13 +0000
Message-ID: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfXzmWaPsCBwWcL
 a9Drmuy2DRao1SyR3/Ac+7DpSUJXH0XvCkuO5Ea7P3g3if/IeP2T1lobd1nwXgK8duQMoJwkE94
 +8dvlJlWZ9JV3A3LiYzZ5tCxqbcZEGU=
X-Proofpoint-ORIG-GUID: uSWVZnoe3waambC3KhqFR3Odr4Q0Wp2Q
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e9e74 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=9qUTvQc-AAAA:8 a=l2YYpDeTXo3xaoTudWEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-GUID: uSWVZnoe3waambC3KhqFR3Odr4Q0Wp2Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX+hkodaVn6AtV
 23y6MUi0kdLxPdUJykV2lSXQvfT83k9G8GSh/qfSRUTF3lDRog2vasZbh4XhiUfdpyyTC0WoGZ6
 TO7R/ogB5qgzotlkKPFndNxvrdoDwtlvp5mBJHqOOkjBrmts8gmAiYSr2KsuOAO/NBiU+vGEbvH
 2qwIqCu/9vAJThlEMtc954nXz6GT5SifeH1Bq1Q93c52R70QzVc0JDqvu9bkjow3yZHevjjvMPM
 Nx5Tdi/btJASgUfviqsKtmy6QiGXbjQUhNqMm+tvGtwfn1NV2Ma6IWnA94CZbFO/BFGbGqW5oVx
 Jp6j7d41y8HvnWegLorg1iyoMCDkPRD3+JYYRrjf0HZRNh2XpArIH6CPLghhKWD4mO4OuJWj58V
 Egj1QUsf8cMqJlOO922hQGVwQBw+xSIt8rn+5j+TrKYQm5MLijauqziJQoSzNwVwRwdtqnhLNUC
 1EADUIyR57lOR99amCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200242
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

It was reported that build on sparc64 host is currently broken, due to inclusion
of asm/kvm.h, which is not present on this platform:
https://lore.kernel.org/qemu-devel/c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru/

Problem is that we assumed in Kconfig that VFIO is available for all linux
hosts, which is wrong. It is limited to linux hosts having kvm support.
Since we already have a meson.build section identifying those hosts, just define
a new CONFIG_KVM_HOST in host configuration.

Pierrick Bouvier (2):
  meson.build: define CONFIG_KVM_HOST
  hw/vfio: restrict to kvm hosts

 Kconfig.host    | 3 +++
 hw/vfio/Kconfig | 8 ++++----
 meson.build     | 4 ++++
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.0


