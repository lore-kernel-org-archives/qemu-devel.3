Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAFCCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNcQ-00039E-Ub; Tue, 19 May 2026 12:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wPNcK-00037S-7i
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:48:29 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wPNcI-0007fy-9U
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:48:27 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-913cc4d7c71so359669985a.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779209305; x=1779814105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4/lqHZRCy3sAKq1DW5PUtGDY6iZILtZtdMIPcKbBuI=;
 b=dHioeM1U5T+qzGhJd8biRJ2A4jZVAyba5BaItxthDdsK9uzv7hk9UBmV1Jxgezmx6T
 2/u9dLoSBPdOZkhfDeq9KoaI9RF3sl9eexASVW1MPHJ7Ukd/XuFSAwcVtsXks+FF05hU
 72n/WMXtsDwvVrNvs7syb+YpyHQY2l2K0R33NiS97FNXc6sGFLnCUSdhBql7OtrzEx6Q
 F30wHTUUAujZQ+55mu8QHj9r41w39bQtC9vBVp9NgNQ1FDhzbkgC8Q7972bgTNR4e5HI
 GbDx9XFHsC/ndoTmc/VMsnZICsuZ24J7UtqN28Drwda7/o9IqYXbIWw8riSIs/W5KiHY
 idzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779209305; x=1779814105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4/lqHZRCy3sAKq1DW5PUtGDY6iZILtZtdMIPcKbBuI=;
 b=QNH8cenPWO4w6d5U5ciDt1Au7kEtyT9nufKSJehQKNVie6TQss+IAHEhNy3ZXttszk
 OWWwJYjX5BhZX+zJcH8jLnwFkYZoyD/FfSql9CEMPd76cgjb0PCyrAaM9skLFSF/98JM
 V1YDGKWuxaR9LIhMZpBEkVHjPuvLc4VlOpzPt9JgGXj1WsljFe0FYPBCfdSnudjG690T
 SQRq+AlEcQpcRD+o72nopf9e3nWsx7e8mAn7q6ATwQSO7HAYcuCDSRmkpr9jMTuCjRDJ
 OGZewarNZ9RUy72njy9gmaYWxWYMmgTzn8A9S4fupuHBrdKIuHWA4QUFR/wxTXgxGbU0
 UtYA==
X-Gm-Message-State: AOJu0YyT2ybkz+1kWdqv4Gcl9JAlC0PoZZIGhPUlCFMvsw2K0YnrtTo2
 BxR7LQgeYwtWchN/kN+I23hH2gaPU0IXLYyUkVBedLDaSIX4JbxwuZtJ
X-Gm-Gg: Acq92OH5+hBnOQgdJvEtQd3SPvx2EWUiwU/JAVU4EjqNQKJOEhPdChEaepXLsSh8bKQ
 LBkAhjUPax09f33+RAK9QxXcDk7nXfCIqmLAVEAcKKaG64KBYQ6jqQUk0QB1BqIpR8juHzNoI3c
 sSVMUkd0y16BXHjCTARWXb74gi2ryUvifGxzx7RPJZp+76qB1zqCmBMQm6FpkpuBDXQSchTJiIP
 Qz9pIWYcEg2+ymrYCK7tSjAwkm7z/ihILUoJ+8exqeV09RZBcGFNMsGwF8n2iYwRL8FMw1wzSk3
 VzyPKMSJUGz6g4f9mIR2bH7jC98J8MvwI7rz2bW2Huj9KQvKbIWkyhX4mNtRk8PJbu1AMi35rRz
 LjttP1L33IYJ6jAGxOD1yj05ER0o8Db4IhQbdLGRAsRI7tvb6vQeBSytsVRBJKm0ydhMNFrpchm
 MOauV5d1fDvS/CyHI/yHQTE5lvTmpLBcndFyCA2JX+ShZL6+Q9JgPVBW3+NzTmQ/k=
X-Received: by 2002:a05:620a:4707:b0:8cd:9033:1724 with SMTP id
 af79cd13be357-911cce886fbmr3068237685a.9.1779209305083; 
 Tue, 19 May 2026 09:48:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:208b:c9c5:39b5:dd2b:4560])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba182535sm1880223685a.8.2026.05.19.09.48.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 09:48:24 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v5 0/4] virtio-gpu: enable Venus/Vulkan without OpenGL
 display
Date: Tue, 19 May 2026 13:48:18 -0300
Message-ID: <20260519164818.22982-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <874ik3d6gq.fsf@draig.linaro.org>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=lucaaamaral@gmail.com; helo=mail-qk1-x72b.google.com
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

Alex Bennée <alex.bennee@linaro.org> writes:

> I don't see the r-b on the patch.

It's on the v2 thread for the same patch (then 1/3, unchanged content
in v5 patch 1/4):

  https://patchew.org/QEMU/20260311022752.64192-1-lucaaamaral@gmail.com/20260311022752.64192-2-lucaaamaral@gmail.com/

I'm not familiar with the convention here -- should the Reviewed-by
be re-stated in the cover letter of each respin, or carried only in
the patch trailer of the next version? Will do whichever is standard
in v6.

Thanks,
Lucas

