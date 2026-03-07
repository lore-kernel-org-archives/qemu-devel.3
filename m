Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CC8FC9EFE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 14:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vysHJ-0002Gx-RY; Sat, 07 Mar 2026 09:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1vynRx-0002lE-K2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 03:55:53 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1vynRv-0007w5-Hl
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 03:55:52 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso5138631b3a.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 00:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772873749; x=1773478549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JNIJD6CLI7qBXlye+nuHAHAnCN0cTaT/HJE+dU0W8QE=;
 b=jqaRBBC5k5TlendqUo8o0DYMzR4ANTXvALef1Vlri7bmbF5scjvpR4YVPaf0XUSs+v
 u3X8ZluDGYFy+B+hlo7J4iDbYo53Q9LgcXmIDTg1yip6ZC88Uc9I+lBc8iisDnJwTjeE
 T+McSi+xswot+P93jzE80cIwi2NGrTK6/9gkC858RqR9LCsTbEMxkOOwCh9HNutTcA6E
 V0ED4/UHV3Gjy0D17vi/KCnEJMSRriItJ9V6elWVaIbS7XPsFvLt/YA0FNzQAAcCeLg9
 6w3y/W+r4c0z5DG01gJv7gPjLvx9c0xL2MzXE5kS6XR30hkVMVvCMfK0gedh+ZvI3cV4
 pbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772873749; x=1773478549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNIJD6CLI7qBXlye+nuHAHAnCN0cTaT/HJE+dU0W8QE=;
 b=hotdzJ2dVJXIAXCb0sAhlf5kXj1AVoTCgyrEmGtgQEwE92LrNnSKE/lz+l1L3yMpnv
 ThxYMfXFOWOh7LNBK66sWovxlveEuJzf7faa8OPg9SKFw+BSlvhIGtUVcMe7ZWqXpHdl
 hTO+iCftMOjPC2G1q4xZmMzXrLHEDOxodlN5lqXvXYn/mvNGd901a2QWCn9+ikz6B2Qf
 JgZ6jHEH5Pw8oRiWwgBn/LSQj3WTJPKpidBevBCvzuMn2nWUOZj8/SY4HvcX4ZDK/TYM
 sSK4vlL9mf3dNwr60qmGBm8ncHGuzyGKJRYi4IbRnOKHiHIhsPPVB3PpfUwZrNt3hJIP
 P6mw==
X-Gm-Message-State: AOJu0Yzhb73Z4qcM663AmpT3J8zLpXDFQx2H3pkVic1GDcccQ3jmwdHw
 /tZSyF7dHyE4CeEv71EXyQw+yLLqWPF/D8jQR4W9HmUcIjDc00kCsWT13366yht3
X-Gm-Gg: ATEYQzzVvxHIBLHfhYmyxZ2ahoWRAlHvShNPpAUl7Vbp0vKcxJ+s2hbT+kzm/7ZI8Em
 c5GaRRuiKBu4c1U3YGnmJVFC/uFSiGN0ogc5j8aLuj1XaJAjveXswdt9kGPyd6JLWMLCpKVI8KW
 9xVrxopv2zP695lUdSr614hQiJq310bGuDbkrKN54hYpXV3E9EdG2mkNI9m4He6YZ0eJcfzIezF
 dlM4bA6x3w7Xvyqpzk8OVSRIO9bve19NCt7uOI9yQJRv6RcFwoInvrd7VIO2Yj0TOJ0bC7VvmKq
 //z/T1dBTTZvSEWRavG0DQf2us1PnX15/nKRMIxKpM+EEdfJWUu6WULambfX0QE77IvhkNu6pUP
 7lLCuNg2UjmA25y1er2SJRnzVO7Z9gt84hDoG/kBj2XUJI3997ynVfFmHp0T1gkpPE4eYCy3WpT
 awjQprLqUWDxhQsgesQWlUfxbWL/zuHdOz/aEL9nWlhJs+KcWH
X-Received: by 2002:a05:6a21:3213:b0:38b:ecae:671b with SMTP id
 adf61e73a8af0-39858e07a3emr5018953637.0.1772873748839; 
 Sat, 07 Mar 2026 00:55:48 -0800 (PST)
Received: from localhost.localdomain ([116.105.225.102])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a465b6d3sm4116049b3a.18.2026.03.07.00.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 00:55:48 -0800 (PST)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: New contributor: interested in issue #413 (error handling audit)
Date: Sat,  7 Mar 2026 15:54:00 +0700
Message-ID: <20260307085404.18364-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Mar 2026 09:05:11 -0500
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

Hi,

I'm a new contributor and would like to work on issue #413.

I checked the mailing list archives and saw no further work related to
this topic so far.

Could someone confirm what remains to be done and whether
the issue is still available?

BR,
Trieu Huynh

