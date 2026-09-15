Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA93C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HLS-0004Jl-5m; Mon, 14 Sep 2026 20:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLP-0004I0-Aj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLK-00049w-0f
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN05QF1985750
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/X0cmuzPBsN
 yNewKfNMraJHy0a4o+TtZ/F93K/SAZ5Y=; b=jV6P1/aL/SaXz4jYP1Wnm9OC4qu
 2FP+RjyIdd2HqnuVCun9Sw3YzBBwmo/AagrEggrZdE0bDvk/PL6xswV9AwZh2izQ
 iIQ5+/Bsgw3uNDnnaE3m/pvmP92gPxfZdQeg0FuBShgwU8oKhx/TVCLR7c/6juFv
 JT3tOGRvCCW+m2qR8ssvpdYETeniUBLJ26sblUN9EjoJatjHmqIvv3Bwyib9vCv+
 7BRN2mMhcJFfLZLsDz6b3Z7noXEmLIcQbHngIHI2L9bFd6av8TI7vNXndiwR6K9G
 q6pBDdNXOGzz9FEsEFq2pz689wdf8TrqF8js1uPXu8yuEsuqMg34liOIiiw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet1b8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2dd753a52bbso11289685ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433292; x=1790038092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/X0cmuzPBsNyNewKfNMraJHy0a4o+TtZ/F93K/SAZ5Y=;
 b=WV5XzBsqMuHUC+XUekqw50RhA0A3IEDOdvJ4V7DnxRQr+SdKSuZ+QXrVtUd5JQxIrg
 un1xJi+zxb96b4T0c2BE6vFSwCX4bXAcQLNJE/71E4FV18s1THU35JoPrFssRuUz+DLg
 ONtJdzvWKNNBVPODdqjIMp/Ues481HhdLVh7iDYHJpr4hl8YXdhEW30ZlbDAIPu7IVm1
 XFc0Ei+EdU+ZXVuyBhUsXfVd0QechHgmYuLoYKjTdXEsb7GbuIMyZpnyXTOjUsvusOE5
 AXijLUFHzdjWa4pJM4FCBxu25Rs29IzkBuBM0edMKZgnhnTp06kKVPbsudP/8nwIiLOl
 26Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433292; x=1790038092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/X0cmuzPBsNyNewKfNMraJHy0a4o+TtZ/F93K/SAZ5Y=;
 b=xi7JB/yFaFOnBjObPxOQoESHgvdp2+9Z8g4KCLg21ZNH8Tt6mfj6KxYoVCPN981ZG6
 Sst0jgUsS7zMu4TIKMwV1O7B+OF+33WVChE3tgax3qvoEvAka4+bXbr0umjyN1Rr3rYD
 kinm6mXT7I5c0cUkLjCWVdMolZj4nFLiPTdkrdNmz1WI4tKW0OmPkNh+Vl+s+Zc3LwqI
 rBWbGrYbTp5uXBdBkPM3rb9ojpKVHFNtg63VwFV8gO3C4qmSEYbZhP4hicIf7j55tvT6
 ahHmvCpWSyBpIbhrZCrpUzROs2Gss5cs2rZzCrr2ANNklhbDKHNOyXyPOlr9g8NFhEpj
 bnGw==
X-Gm-Message-State: AFuF++mBMrHyfUMPmReEWSztc4QkADLbmUpqWl/dnvOo2i2mpPTk/8KD
 tbZ8+9VwunSipVvcf+PPi89muy7DOmAJVQxn59ZqpGJftK5ReYo8dxWjpSMRebnwRNrcjcDlgZd
 enPRnKco93LHvmTaNsKeygxLyCk0mhFVjVbJfXfmilQFnJMysqd3HZ7KE7yAfrpm0dg==
X-Gm-Gg: AYBFou01qrLlDYr2r/Q6+BzutUrf7vv80nOhwlAy8GbxSAmaT/hMYn7IPd1dIPjmRe1
 PTS9D9YZRocX/D5aGS+lvOTjl+WbGUlRHsJlW1+MlrtBehKurTZCkefvndCWhE+8LkOtSeAubq5
 +/pev7yrk3ySCo7QkN4tVzTKZVf8COLeU/0B3DII4n8B3vnbMj3wlCIbDsYp4zOXdc9Ku5z7lHs
 RkgMNiQKAxRakvsBlmtUqRrn8sU8GTUgJ9g5oN01GO0N7BhwX/ISiBn+OQUJpXsPQFHRRj0NXsa
 uMa1SpHj0zsPQqjekhlJCmkvTgDgIJoh/o3GJAPfBHF7l9M9Tpv0ZmbhQy5uYWoGXeqYK3Cdn8Q
 be0mXYXc+2bI1JNrLw3NqeVDp7k4bFlV2vz0TVvb63WSLb/b2sfOrmBXAoj4=
X-Received: by 2002:a17:903:35c6:b0:2db:73fc:b57f with SMTP id
 d9443c01a7336-2dd6c6c0cc0mr96683535ad.10.1789433292036; 
 Mon, 14 Sep 2026 17:48:12 -0700 (PDT)
X-Received: by 2002:a17:903:35c6:b0:2db:73fc:b57f with SMTP id
 d9443c01a7336-2dd6c6c0cc0mr96683125ad.10.1789433291598; 
 Mon, 14 Sep 2026 17:48:11 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm31978309eec.4.2026.09.14.17.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:48:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-ppc@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 2/6] roms/Makefile: add vofrom
Date: Tue, 15 Sep 2026 00:47:58 +0000
Message-ID: <20260915004802.5749-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX6EOlHWJvUPQH
 B3cmbUX5cgLw3k0lT/vwe71VXW/JNeB7eNpm1It+Mdi6slCVT2zDpOprYNN3jZdn42x7Q46Mm0W
 u/wrQXsQapQuCUafhxGIrwxQpDlSLKU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX4scdXuYAfLeG
 ocnQU4wGyEuMYnNhK8x9Nz+1DuPY/5HlewjfW1JugRXSHCgJAWi8gdAVufTtd3C3m3SHOM+ZBia
 qM7XbliXi4tmPE/il+aKIM0Xbiz8XhlAFYpvQv7pjQM4Z3X/7YvnkagUzsVOY/SAL061mc9Rv0d
 C0forxg6MBSWuUNWkSZJd3KfKjj+OUzcBEiL6ALLz/rdCeM9rLk6FLLK+Py4ug02E73a0zz4R9I
 ic4EdVA2/h0tLMwJr1oIB4irOicZHHY4otUV4atFt61+KSyhyDVBHzGjWGZalkcdSrPJJuF5rRe
 feRHhBMOHJVKdbvlPY5VPQluPXRAT+6aF4ERqn2sz9k3RIHso1AjZ5M3RDfzNp6wHSwALEiBSg2
 9U33DEwF0dlx5crzsOwhdsEjl0gGenqfoNvUM7LHeKbSldkmsP48K3cxsspr5NBXm5tL6tJWiLL
 hncE90NW0WO3RlJYGrg==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa895cc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=0g6KD0rpRfIU_7JGXwsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: qK1DQn8f4N6wIlSZG_a6rz7BuOLL12Po
X-Proofpoint-ORIG-GUID: qK1DQn8f4N6wIlSZG_a6rz7BuOLL12Po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove dependency on config.mak and simplify Makefile.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 roms/Makefile     |  6 ++++++
 roms/vof/Makefile | 21 ++++++++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index f15189a5409..84f22943d35 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -63,6 +63,7 @@ default help:
 	@echo "  pxerom             -- update nic roms (bios only)"
 	@echo "  efirom             -- update nic roms (bios+efi)"
 	@echo "  slof               -- update slof.bin"
+	@echo "  vofrom             -- update vof.bin"
 	@echo "  skiboot            -- update skiboot.lid"
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
@@ -136,6 +137,10 @@ slof:
 	$(MAKE) -C SLOF CROSS=$(powerpc64_cross_prefix) qemu
 	cp SLOF/boot_rom.bin ../pc-bios/slof.bin
 
+vofrom:
+	$(MAKE) -C vof
+	cp vof/vof.bin ../pc-bios/vof.bin
+
 u-boot.e500:
 	$(MAKE) -C u-boot O=build-e500 qemu-ppce500_config
 	$(MAKE) -C u-boot CROSS_COMPILE=$(powerpc_cross_prefix) \
@@ -217,6 +222,7 @@ clean:
 	$(MAKE) -C edk2/BaseTools clean
 	rm -rf edk2/Conf/{.cache,BuildEnv.sh,build_rule.txt,target.txt,tools_def.txt}
 	$(MAKE) -C SLOF clean
+	$(MAKE) -C vof clean
 	rm -rf u-boot/build-e500
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
diff --git a/roms/vof/Makefile b/roms/vof/Makefile
index d1eb6ced7ec..d5dbb374356 100644
--- a/roms/vof/Makefile
+++ b/roms/vof/Makefile
@@ -1,27 +1,22 @@
-include config.mak
-VPATH=$(SRC_DIR)
 all: vof.bin
 
-NULL :=
-SPACE := $(NULL) #
-TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
-
-quiet-@ = $(if $(V),,@$(if $1,,printf "%s\n" "$(TARGET_PREFIX)$1" && ))
-quiet-command = $(call quiet-@,$2 $@)$1
-
+CROSS := $(or $(CROSS),powerpc-linux-gnu-)
+CC := $(CROSS)gcc
+LD := $(CROSS)ld
+OBJCOPY := $(CROSS)objcopy
 EXTRA_CFLAGS += -mcpu=power4
 
 %.o: %.S
-	$(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -o $@ $<,Assembling)
+	$(CC) $(EXTRA_CFLAGS) -c -o $@ $<
 
 %.o: %.c
-	$(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -fno-stack-protector -o $@ $<,Compiling)
+	$(CC) $(EXTRA_CFLAGS) -c -fno-stack-protector -o $@ $<
 
 vof.elf: entry.o main.o ci.o bootmem.o libc.o
-	$(call quiet-command, $(LD) -nostdlib -e_start -T$(SRC_DIR)/vof.lds -EB -o $@ $^,Linking)
+	$(LD) -nostdlib -e_start -Tvof.lds -EB -o $@ $^
 
 %.bin: %.elf
-	$(call quiet-command, $(OBJCOPY) -O binary -j .text -j .data -j .toc -j .got2 $^ $@,Extracting raw object)
+	$(OBJCOPY) -O binary -j .text -j .data -j .toc -j .got2 $^ $@
 
 clean:
 	rm -f *.o vof.bin vof.elf *~
-- 
2.43.0


