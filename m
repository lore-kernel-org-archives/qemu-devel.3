Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B93FFE51F3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCny-0006ua-Tb; Fri, 24 Apr 2026 05:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wGCnx-0006uQ-Rz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:26:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wGCnw-0007Cz-2X
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:26:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a8f97f6bso13773815e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022789; x=1777627589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/fNlE9Gq8hOLhLNzmtET6bZPUEb/hYflGWPOgGcCjo=;
 b=XreX/QNssekhg7j3n+l8N8Rvh4GWHGohaDA8jrx5ekeg7dkDEOeL6b2Ojkfo+bzZzQ
 JNzu9ViBDKCTtC7Jf3cRKcJBLSGeadSKEKqFX5J8Fvhxxso0ydhRZYzZriByPMpu/SeM
 V8iCfd7D5ykg4HmWdbOOVbA9AUpDEcyORQvWURUkha6W6c0YT+OmIQfzLTAkhjTyBv9G
 8998PPi56zDVF0Deqn1FAG3TdAgsvJgDn30BLeC7bUTIW7t2X8/VBtUBNPM4gK/ysPBc
 MciQWq6YsJrtipsteRDaxAYWIbzQGcIDBvJeaEyzOgsOlbE0byy5dnwsvDZ3t5mehoKk
 7fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022789; x=1777627589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X/fNlE9Gq8hOLhLNzmtET6bZPUEb/hYflGWPOgGcCjo=;
 b=DgXT56uoJ3w/AwJMi0Lx3Igo5lvGb3+jKnDDpIh/UGYmLYXGPa03GOXruQSgFf9WFZ
 2BVnoRF1tBRhL4E1usht1301DiERxXNY5sMRh0jiKm2CvgPvRc2oncjhugPTzlUlFI8v
 cZgnXivyIgI2Mli+Ee68eHGqd7Yu9ld51F0i6GQImvAcDslwisIxlv8j4hbKxiaM2IrO
 stJ4laGyEan228vl/jj1ND8oaQJFLwZ2EqRwcaUnPT9JO5w2CaVuPoHsCemOuVsmFQYz
 k12tM015HyjTb8w5ljRrNI94zzQxrf+y7g9E2CrFg8rPatglU3bDpEkaFV9mE43okPN8
 9klA==
X-Gm-Message-State: AOJu0Yxm40M1Ve0wtGPF4TNPoXtF2+pIK5T0elb/CJbmZqwR4Pe3WRGw
 V21W0ve9F/wamy0PE0XqfFs8FZ/S9VrutPwwkQQcw8CE4V//Zn6tdL4D
X-Gm-Gg: AeBDies9+l3Vunt8SIMeuRDlGiSZWTIXzxpTb8MKyZtCAKtIxeJ+zCTqN/pXTVOVLhC
 uCG9KWOAOWV4q6YGjj0+b2PcoJELE40q9vvMCOy3xfEfOlA4SroyTvdCkJ6rUofLcRy/ykOOXZM
 4wWaar5gx676H7kJkmZ94YWQuRI9ostVIRmFFa9BSxwBGPrnsy7ul6/rvpDifhMwxiY2uXpdL2I
 2C63g46NoKSRYRw5PBgrbfbwbk8zu7pO+HXd95T6f1NXpKLFHNgjoXjX7E7FBe6wQ9cdXYy0Fr+
 Fh7yIrAcVY5V//5FpD0BtsRrkg/Kac9sDHGTgI2eRtPILXTER4RL4XgpsxsCaVQq48DcJb1aoOP
 cpVmcPDD0I8KOw4Hk2zkgOMHwckcUSjs27rZbHI4OWXfi9w5tgWUdSW+zV9xYn3EX7glWwrKE2s
 14/p3S2kroNUlAEdjym0Pmv6P6HtqOEBrrxIZoug==
X-Received: by 2002:a05:600c:6289:b0:486:fb8a:fed with SMTP id
 5b1f17b1804b1-488fb7897camr233112795e9.8.1777022788899; 
 Fri, 24 Apr 2026 02:26:28 -0700 (PDT)
Received: from LAP-0337.. ([182.176.170.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm989823515e9.3.2026.04.24.02.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:26:28 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
To: deller@gmx.de
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, pierrick.bouvier@linaro.org,
 alex.bennee@linaro.org, morgan@kernel.org
Subject: Re: [PATCH 1/3] linux-user: Filter /proc/*/task/ to hide
 QEMU-internal threads
Date: Fri, 24 Apr 2026 14:26:23 +0500
Message-ID: <20260424092623.94809-1-elirazamumtaz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5b9fe9d3-6afb-4cbd-9b41-46b82cb5b974@gmx.de>
References: <5b9fe9d3-6afb-4cbd-9b41-46b82cb5b974@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/15/26, Helge Deller wrote:=0D
>> +            char *endp;=0D
>> +            long tid =3D strtol(hde->d_name, &endp, 10);=0D
>=0D
> I think we should use type pid_t here:=0D
> pid_t tid =3D strtol(...)=0D
=0D
Thanks for the review, Helge.=0D
=0D
Agreed, pid_t is the correct type for a thread id. Fixed in v2 for both=0D
do_getdents() and do_getdents64(). I also switched the parsing to=0D
qemu_strtoi() so the whole entry name must be numeric (no trailing junk),=0D
which avoids relying on errno/endp checks.=0D
=0D
v2 also addresses a few other issues that came up on a closer review=0D
(TOCTOU on the readlink-based dir check, a false EOF when an entire=0D
host batch is filtered out, and tightening the tkill/tgkill validation=0D
to host-process-local checks). Full changelog is in the v2 cover letter:=0D
=0D
  https://lore.kernel.org/qemu-devel/20260424-master-v2-0-8b50b5c063ed@gmai=
l.com/=0D
=0D
Thanks,=0D
Ali Raza=0D

