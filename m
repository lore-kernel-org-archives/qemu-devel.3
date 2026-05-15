Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EE2CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyJ-0004nH-Q0; Fri, 15 May 2026 17:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxx-00039q-Pm
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:07 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxv-0003C8-Rk
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:05 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbec19732eso372478a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880063; x=1779484863;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MkDCvLx1YmIMhnQzW256KXrvrqxkaXCRad8HV/Ubdis=;
 b=OApDRZnIeGGl9uTUvuy/HDiCGMIz5RVeIV2bhItDov+iKmRg99r8Csd0nk7G/ST3Ds
 ZtDE8ifLcL6qrVDhex5To27VSXmGc6NPeIrT9FEJ3JhtDMeJCAxo/xUVPoFBHhLZRaKP
 ckSYRjNj3aRPBtYdJQ+5SIXDuiAfqgse+lHQhb+WtD5alyxy39OJ/Ti+9TGrBAPyiMuP
 4JXiJPZbNSmPPFMry6q/IJElWO4z/VjUhIUDdfssowQd0KKLAYnSyyOnLqPnFjbZqLKv
 CHzEvVa8fTJCzLjSKq4mRVyKB1O32SOw6wghz04vnltNTGaCc/PsJFz05RObfFFmVMR4
 SfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880063; x=1779484863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MkDCvLx1YmIMhnQzW256KXrvrqxkaXCRad8HV/Ubdis=;
 b=b/eGy0AeGHJiDRzbLr7it6Yb6kGivY9xJQGlq/amalyq25un9UiAzM/Z6VH0SYyJPl
 NPzkl0pMYaM8niGUN0sLPxtrYgbZhK438PLssdIeAoZ17wt9ng4narNb8vaUY/+qRvw6
 ExYvfg1q1IuEGhDIDunvL0BmwHfhXGQ/0dWxTonBadKwMqqYcetsM00F+hZeZdnC+am9
 u/3qJUh4DHtX/8dNY2ZMh+FdehQwYEmOMXF+XUBW5UK2EzYA/LyTE08olva8NTHVCpkM
 Fjf7Sga/WG/vZJ5M6Bi/PWhmjF8yqfUEgznwCNV1p1jhCVmN9O2bSLnAsVlOnALfa1Hg
 MH7g==
X-Gm-Message-State: AOJu0YyUpTtmutNgVOgyfJUsUyS0qLweJXquL6uprB4JAUSO3t1Zwx5z
 5TLFHFtBK+E6bMKN/s+pmpgCv4rJReKja1aRoJVaGRtuvJg19VXlsg3ceIvGGi2ZgHIgG1Cwu4z
 yDfh649M=
X-Gm-Gg: Acq92OGg9VdfCGsavQMycU1e+vOACogtKlMTV5/1t/fph/lcgMO/C2eThSvJ7/eCNSr
 qu240ct3NknygU0/O/sYvdqN9aazC78D0x/t8FP39iqn35RSDgwN/sRL5CnrS0+s2M4LrQIL41D
 ZvVhPVB1BrV5JMHB9K0sz3teGSR7GuOT6ieIMlgcAossvHthHyWBuixz2XY4nIyB6I+peuC8mf+
 skvvJjC1nseBAlmbbJy82gtUcj+pZ1MEocRTYIshP4VRnk3N7rvaBumyPpkc0Eib/NWRtC7E5Aj
 Xcz0nbYSzxLyrb8aouKI8v+1e9UargE1ITX9uqtwwO67zpY76o0+ZJrqPo6lrb4OYo0FKhPZRpt
 o5OFlToyul2FUj8E/RgU65isnW3UuDZqqBx9XHzgvLPr6hORs/ujWr6fqtJVhMCyrYpdaJl+9Zr
 Jbd2ozJkkwtg==
X-Received: by 2002:a05:6830:4990:b0:7dc:e37b:b5d3 with SMTP id
 46e09a7af769-7e4ea057345mr4035114a34.7.1778880062726; 
 Fri, 15 May 2026 14:21:02 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:02 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:57 -0600
Subject: [PATCH 58/66] bsd-user: settimeofday should copy the data in, but
 not out
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-58-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=hqBMQ4tUXP5fH65qKhCXQAlD1x+TbgD7xpnPUEQvdAU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43oTSszvYrCcDoy5A6G1XaRh0krgL8xZjAM6
 BWYhEGMSISJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 ALllEADcwMDccFeTUZg20NSSkxjIBtBbJPqDnJNFxYW2QthmSFlkSm5PkmVVEzdrHjLq/9/x9oL
 aIX7sg/XsHui39ehs6ZuAzULkBg1YAg5IrPglvePUWKiNm2qKONB4C+QxAhkA2ZIqcZf/1SroPi
 8L9ledT7DU6blXPHmPEq8cn71SLlIhP9tZ7FK8P5GIF1IdluFUl+oBTdrRaSgLcRqIGR3fAwY8S
 HptbrIETbUU7RRgbwKYYZzJL4RHAGRyaJzfc1YkcuEidbWaYKoRasbBpxZDy3FCeZ4+3TBEuTtl
 TbVexNDZCKnay9ujGzCmshYwDD5Jr6ZFjV2PUyEpk90HoqaiR1VBM6/Q/0mLRs1+e5xXGJGWUMw
 zdnEHY1ARsC2YQDPZF8OvFENi4tPXWJFnM0QUJdOrRLhbcGOk9MSg7W6NxS3FR68DtZfOiFyXCW
 jQ3H6SyWv9cM8ZUt1gNvGni9GuvuARnR3xbitB9fKtOUDO4Hk7dhgKGL71K7NaQXlr/7ehqqX48
 UINR6/R3CKXd3SxOTnBzKi2oG2GKcuEtGAMdKzmclzHBiK1N27Wm/NCYEg73suBdpz8lti4NzJv
 FzOTOslcTIde3LSJsxTnUy1JdMk41qFeWxs58QEpMz3SzlZKsFbE3T6FsoBLTPzIJLhjL8CRQJt
 3vgphBeDXowjIwA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Make sure that we copy in on lock() and don't copy back out on unlock().

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 29436997ce..ec379b6927 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -149,12 +149,12 @@ static inline abi_long do_freebsd_settimeofday(abi_long arg1, abi_long arg2)
     struct timezone tz, *target_tz; /* XXX */
 
     if (arg2 != 0) {
-        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
+        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 1)) {
             return -TARGET_EFAULT;
         }
         __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
         __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
-        unlock_user_struct(target_tz, arg2, 1);
+        unlock_user_struct(target_tz, arg2, 0);
     }
     if (t2h_freebsd_timeval(&tv, arg1)) {
         return -TARGET_EFAULT;

-- 
2.52.0


