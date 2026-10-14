Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C30CC6B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6An-0001Qt-QL; Wed, 14 Oct 2026 17:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ak-0001Q2-Lu
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:06:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Aj-0000j5-6y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:06:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EHQu8C841683
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F2B+khBvMWQXkkFkaloUM8fpk04OZFa68FV0y4gvwGo=; b=XT/sJ9GElwmPbmRs
 kjaP4u5AYnqzdD3TbbWyhcGk/8MZpv06TbcK8VAB8hG4aDTwKmfObODDHMkCY9Wg
 txpkC6KuMlnM2hfnLZY1lyqe/ha6l3uJsB3Dok72JI7ZYCBKvRBz4+zMybqCAOH4
 3p7GRhqBnViB0bcnYzajrSrUQFxjHx5Y27Fuv7IbIBiWr14FTs3pdXGu7/EOgCeV
 qvVUodxLwpUzVAf7++6rIFx2Bpq5eG71Myz9YxQhZZ87yF6qLEyY9MFRaT8v2lCr
 5ye5E+Y+d2+2oBXJDhKouL/EJlTsfSdYoOyzolFB5wF5yWAnZFQn8JyMI5uKV4wM
 r+qO3Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wrrq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:06:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso8438201eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011959; x=1792616759; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F2B+khBvMWQXkkFkaloUM8fpk04OZFa68FV0y4gvwGo=;
 b=VuvtKPsApSMvYDiI9W9RBqzlTcjxUiGYaqYJzTgX/pTfLoDrfTTbtCSaH2q20Jw62w
 QZhj5HHo+H0D2Et1PVoEAm6RYrcLdE3KVgIdRym51wbdvSo5IfDXuo6geF5Y42MXKEGA
 4DfCg/MpCUdl0/j0jB3hAXWrF6Glm3sLxk9OLVD9CxbDGVvjWjQoxfNGW3zv0pxQdE8Z
 Ijq26g6abA7wHrVEG0I/AAPk+RbM86+BX3pxTZQjj9jbwhzWXdNWl0heu6OMoKpQV+nW
 PM5c8UFx7ipwl8gV/WPOuvJiQgbva6LG/tR070FJeBWbaGMtYe9lT5WO4hCUUhUKH+ZE
 OGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011959; x=1792616759;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F2B+khBvMWQXkkFkaloUM8fpk04OZFa68FV0y4gvwGo=;
 b=O1Bx6WUVm92m0hJYPdEHqOZneOzlN5yKDjjdmztMz2ApfsU6N7mzoLFGUuAgjJhdtc
 Pt8iQ9w/tTy6AlLZvYr9Uyxq5Z4wPOSD7fApHru8PRcW1bptRJz3tnohAzIiJq353sFg
 AjXViSxCwi1TpzJKedgmcFfx5Oqw/PgxSdenqy7vmz+G7rcWv9baoBwC3d1GRZRa8rZm
 jvbb1a6MPFDK7A32/X7KH7np9Na0IeyWqYt/LU+oLkWg6CRt5hkZyXF4HT/W4ojQJJj7
 fu/iVIL3gqoOrJTIaSqRUPgxdUALQVzUDPreTIn954JAb+zNS1LLZdvzrxkU+oLVE5NR
 uryQ==
X-Gm-Message-State: AFq9FYJLwnBawERFqDSnUobaLzsWgVRu6GfpwcG9a6B+P/z+W2GrMtnK
 ceqg0VDGhdRZGRPPqDBFI0vg9VcFxAWkDn163YvKMprD6figi4eXdO0QFo/sqv8KgGWTZNqIs/G
 GySoC/6LeKFzC82OtrlTLmXwUQG5NPlDzbthbJBfiOPTZmF2gwNMXJaxG8i9V/2PA7w==
X-Gm-Gg: AYBFou32ohSNR6bXe6KiEsFI8vfN9b6YDQ5bTNFn/Rz/5Gs1YqYV6a9RGxe1g7RQHDl
 FYOJ2JXNCpK8jwPelg6uFJWQLEJs/vIF30Il4+JRoYs0PK9CJIo4L1oZLMK9XTCvPqPpjWHhzyG
 ictdLOq2uViL9EAxZDAI8lwwvnS4Zt+1YZ7iuvlqK9gfmSu0M5znTCfI4fsRG3Khrpwn6uhaLSl
 1T6vwMXm6eogHV8qVZsP9EfvSI0x4pKVzWZKAwLIcO3HnOnPyxfdH/HRJEMDuTrxzr/irpBkTkw
 wkiKLBAlVBz6S2NmkJxqt5oUxuBTjUKu0MSR3svVSZthd9L+sTe0zNKhSEj4wRGytzkA3jUVvkR
 y368ary5FS8Oe+B6arT8HEjA+ML1ZRWNnDZtSJ3V1sREz8vo+pnHPs3Jz4uc7
X-Received: by 2002:a05:693c:66ca:b0:35c:f667:8b9a with SMTP id
 5a478bee46e88-35cf6678c8fmr6953120eec.6.1792011959134; 
 Wed, 14 Oct 2026 14:05:59 -0700 (PDT)
X-Received: by 2002:a05:693c:66ca:b0:35c:f667:8b9a with SMTP id
 5a478bee46e88-35cf6678c8fmr6953094eec.6.1792011958563; 
 Wed, 14 Oct 2026 14:05:58 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 12/12] meson.build: add hexagon-softmmu to multi-target
Date: Wed, 14 Oct 2026 21:05:26 +0000
Message-ID: <20261014210526.104215-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX8F5B56VSnOOy
 ukFlszOp72xjYzKOJgL2rZxmHjYq2pwn0bs2RCgmWAglTUmctt4z/qWZPkxYGP/Ihr/0Z+Cd+vq
 qZCGvYDzKu0tKhfIxblLOhLKoZK1oHw=
X-Proofpoint-ORIG-GUID: 8ca5wT7ys-c4DTjfpWhuXHSyFx_30agC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX/Qc18aGExbxP
 iPi6phNLfu/SlxsxAUPzG1TKfRTWZ+DLnvLsfZ42CoswHIChQL171butdLCdIEIqzgbIH5IcjOi
 uVpWmVoBWZERnr1tePSmMdE3fmoJRZjLBD2a4EtUxRr93DX9mWgCSex4q25kWWj3icXsJcgJxLV
 hrIaT7cBR9xE1igdLc0p578cxU9Hl2V5ePiNaYS+vDbEe1kHS+IeGvpR2EyokrzIPhKx9g5UUqD
 SnGRoLiSA4wjAaNLJ0UgPTccZcI/jv5/RRQbymufa7tZvwP2Cj5eK73mRRv2l7R/wrvj1l8iZxU
 TS0pLyTO0rn9Eei7uje+gX3CMdBwLc8VL+s2zEozrk9kodrJJOwd5N2Cg52/YQfFBQaOerKRMH9
 XyNLfZdI4ABFTGmCqLHb5leQrFplsPNP1MWZRIdamTB+qREBjEfcF045Z8z6vAqlkzx37qFGBag
 YbyozV3dDj287pIf9rw==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6acfeeb8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 8ca5wT7ys-c4DTjfpWhuXHSyFx_30agC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140084
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

Now that semihosting is solved, hexagon can join the list of target
compatible with others.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 255c887e8e6..e37ed1687e9 100644
--- a/meson.build
+++ b/meson.build
@@ -4272,6 +4272,7 @@ multi_target_supported_targets = [
   'alpha-softmmu',
   'arm-softmmu',
   'avr-softmmu',
+  'hexagon-softmmu',
   'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
-- 
2.43.0


