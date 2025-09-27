Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54FDCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 00:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Ihd-0006gC-4w; Fri, 26 Sep 2025 20:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1v2IhX-0006fp-KD
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 20:22:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1v2IhF-0006Qo-1U
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 20:22:11 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77d94c6562fso3108933b3a.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758932503; x=1759537303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tQTR/LW73pcGQZucVeSjNBBl318LBz6n0O2J7WibIuY=;
 b=F2pcF9MRJ6R0bd+pynE+VUxIYLqE/y9ckcPB8y2XQVLTB4LE14BjRskWfSMhVGFmM+
 gkgrTtFHX6evp9ZlEd4qWjyLyMA3VDQG3blqYh9lfB+KIJGLyCBvbpD6jQe7I4V95V6t
 XU6eP5m+LLkimLvy2TpuGBzv1U97nyn5cwbDhKd/pzauS8GtGtRQCY6xtsUDggCCDJ4D
 yZ5glENbT/t7+48zIgFrh2gnRbYDxeBPTsU4EtGH1DDrEHZaNCBjnKSMQ5GhanoMTjA9
 wfZLw6VCHIQnM89m2eOStbWsHaTvZPEUoBDBu2vCv2+wRVus+s4vyPs8HDm1opSISTmV
 m2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758932503; x=1759537303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQTR/LW73pcGQZucVeSjNBBl318LBz6n0O2J7WibIuY=;
 b=DJoSfV5x/L1TPBl1+uHMJwfR7BvD9yHLmCamV+Irx4xg78ByPochwbRr30Qc8uMmP8
 IrH5YIpHUxllNueD3bkkyUUSdtS7SjKwRSUIbrkOVQ3RcjA//buW03YM9F5lGdLhDcvN
 Wxl3vehLbsx1SvGXMcEUkmmK55vVkdSUjmt8hEX9+Tte2xEBguKAX172Pe/W2+H+F+2u
 p7ZQeOxsItm53IlurbyoVWB2UEY5hFzvGXCW9sGfJSD3pXVGBdqR7nX4KvpfaIKLt2cZ
 5i50I4pC1VIrrPC37TZjvBe+fQQ6P0idsviYONh44jX+kpCBlXCPwZiboqAPzivFaZ7m
 e/dQ==
X-Gm-Message-State: AOJu0YwbKBaRNx5q7bmdCHyxLNqZbYRrTh7664eSVqi2sACyWsNmmxPZ
 6gjH9Ft7LWmwbjTHlY5E5AK88a7NiYj3QvwzcvYKeYYIOsP9b/yF3klBZXjXAQ==
X-Gm-Gg: ASbGncslQ8Fps1FQA2NQbtTQNFwuxeB/Y9DD7l9YJk/+efLp+pcBY4/dGszx7JLn+/s
 us1ljJ5ajbUQPt3VXu5kbJ/1PLCFHaAizksFKxUGhkcZVyD+ER05aVgbsVaaE7/uYrJ7xVglkgW
 zbCX6VCGA42T0T/Vlz8scIlNC36Bmj4SEtIV/i532DXZdnZmHqwgLfX5XkGao2kF5qn551mZIW5
 TR69xfkdy59vtvKPafCWIc3J7OpTJaoDl8WiDObpebnJE8gg8b96NFT9/iw1JqtVYwpoGH1N0mn
 iRs/WjluZZgb8EAQ8qEN28e1RqziLMaLlOaI+nOA5yCanLhzJu/0nWxvASeblZuaHftTqs2xnA1
 C7yEKWeWjf2EQSsBNqxydTzSLJAgwwx2rZf0cxKzsOX9EP8DorrMEag==
X-Google-Smtp-Source: AGHT+IGxmhCV2WruVI+XO8VL9LJ3RKewJCIuMAwgl7jSu9H1qilIOZb32R7DmoucZ7lRJaQj+xypGg==
X-Received: by 2002:a05:6a00:acd:b0:77f:50df:df36 with SMTP id
 d2e1a72fcca58-780fcec5cedmr10386545b3a.18.1758932502876; 
 Fri, 26 Sep 2025 17:21:42 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7810238ca29sm5350489b3a.6.2025.09.26.17.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 17:21:42 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH 0/1] CXL: Enable FMAPI Add for MHSLDs
Date: Sat, 27 Sep 2025 00:18:06 +0000
Message-ID: <20250927002125.860668-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Anisa Su <anisa.su@samsung.com>

This patch adds support for FMAPI Initiate Add command (5604h) for MHSLDs. It
is based on the following branch:
https://gitlab.com/jic23/qemu/-/tree/cxl-2025-07-03

This code was tested by starting 2 VMs, host_1, which initializes the MHSLD, and
host_2, with the following topologies, then sending the FMAPI command from both
hosts.

host_1 = "-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-mhsld,bus=cxl_rp_port0,num-dc-regions=2,volatile-dc-memdev=cxl-mem1,id=cxl-mhd0,sn=99,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=cxl-mhd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k"

host_2 = "-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-mhsld,bus=cxl_rp_port0,num-dc-regions=2,volatile-dc-memdev=cxl-mem1,id=cxl-mhd0,sn=99,mhd-head=1,mhd-state_file=mhd_metadata,mhd-init=false \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=cxl-mhd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k"

libcxlmi is cloned on both hosts and used to send the FMAPI add/release commands
from both host_1 and host_2 and the expected behavior is verified by printing
the response payload from the Get DC Region Lists command (5603h).
The following interactive program from libcxlmi is
used to do so: https://github.com/computexpresslink/libcxlmi/blob/main/examples/fmapi-mctp.c

Question:
Currently, the input payload to FMAPI Init Add contains an array of CXLDCExtentRaw
elements. The mshld_reserve_extents() function expects a pointer of type
CxlDynamicCapacityExtentList, so a loop is introduced to convert CXLDCExtentRaw[]
to CxlDynamicCapacityExtentList.

I am wondering why the typedefs for extents/extent list in qapi-types-cxl.h
are separate from the typedefs in cxl_device.h? Is there a nice way to avoid
introducing a loop here just to convert types here?

Anisa Su (1):
  hw/cxl/cxl-mailbox-utils: Enable FMAPI Initiate Add for MHSLD

 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.51.0


