Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C5AC54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZv0-0006Dr-Kv; Fri, 08 Mar 2024 08:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riZue-0006Be-RS
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:05:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riZuW-00053D-Rf
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709903113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VvAfo45Jv4F6T6gd+Qjfxy0W0/zo7ts+kLTV8Nly7jA=;
 b=PhurrY7sBVUbDF08DfvBcTnHHnwbmiqHO7NFEhcbcWii6zPhMPN4k3w2DHZqhTjKCj8yi+
 E9MvKikzeWqVx0QOAJxxonRZF/E1vaGbeM6prL5qtvDftZmnJuA3sNjMyqkrW91GUuKhdB
 eHntAIJfjcBIytEXJYqOAkDp+OPf6mY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-DMHnQDU-Mg-PA7872w5Yjw-1; Fri, 08 Mar 2024 08:05:12 -0500
X-MC-Unique: DMHnQDU-Mg-PA7872w5Yjw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a456c9d0717so112392466b.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709903109; x=1710507909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VvAfo45Jv4F6T6gd+Qjfxy0W0/zo7ts+kLTV8Nly7jA=;
 b=Tqknu8zOCxa1xItApM7RqgY1yXASNkay9avxlwp4MOjtWEOFFOdVoHtYT1wohPVGig
 zCIoQyuvW6woPcVaz8OGBXHxMKT/85KmsZxHwKsRjKAedLeHAxISbkdDc3DyzVVAw7A1
 h69r3gVhZCSR0DBvXVFvvKNBI5cnxKZhAf8mfP66Z4VPFyEE5I0idbhRGH58CyleLpLK
 HSyIMwCZt/pFvZ0tLbgN5Bp+uxkF7TaQX/P8P1/w44Dg+BeLCyekavGL0sLyeVhb5wkp
 WKcx2m8kkJi2HphtS6mmdqes/bIfivHc+rkp74aJBYhHVxCBiqijYACM+93XX3i2COyO
 r98w==
X-Gm-Message-State: AOJu0Yx4jqk7h94tJEydk/7/lmt336CYWRCIty55d4GP/6Cg6jFKY6Lm
 REuRomHUe9LWnqA6Y2oAOU7VAEzU+14JoC0Esfh0TwTR9qN3rfaP3Tzj9iH5psyxsu6whspLbtF
 M0Sj0wu2JpG/ro2xoVYoVCNPYJJLrj9a8o3isxdsB+S7XYeLZc+u6IplcMZS+pVYr3g+7w70P6C
 0sHi8AJo5abFY2TL20hrgT0iepKNqdiUeM8+9y
X-Received: by 2002:a17:906:7f95:b0:a44:2b:cdd0 with SMTP id
 f21-20020a1709067f9500b00a44002bcdd0mr15934525ejr.20.1709903108895; 
 Fri, 08 Mar 2024 05:05:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/M4zCrTHYlgks1Gx8Zxkk1FkCZBqCOd8ATYUJIfxN0mF4c3CHR8lH2XyajN5XoJF6pQfe4g==
X-Received: by 2002:a17:906:7f95:b0:a44:2b:cdd0 with SMTP id
 f21-20020a1709067f9500b00a44002bcdd0mr15934507ejr.20.1709903108441; 
 Fri, 08 Mar 2024 05:05:08 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 fw17-20020a170906c95100b00a4576dd5a8csm4906778ejb.201.2024.03.08.05.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 05:05:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 0/2] ci: allow running Coverity Scan uploads via GitLab
Date: Fri,  8 Mar 2024 14:05:05 +0100
Message-ID: <20240308130507.582097-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The machine that is used to upload QEMU builds to Coverity is used daily
as a development machine by Emanuele and myself, and as a result sometimes
its podman/docker setup gets messed up.  When this happens, Coverity
uploads might stop for extended periods of time.

In the interest of tightening this and of depending less on infrastructure
maintained by specific people, replace the manually-managed crontab
entry with a new job in GitLab's CI; this is also what Libvirt does.

The only change from v1 is better documentation of the changes in the
script exit code when the upload check fails, for example due to a bad
token.

Paolo

Paolo Bonzini (2):
  run-coverity-scan: add --check-upload-only option
  gitlab-ci: add manual job to run Coverity

 .gitlab-ci.d/base.yml                   |  4 ++
 .gitlab-ci.d/buildtest.yml              | 37 ++++++++++++++++
 .gitlab-ci.d/opensbi.yml                |  4 ++
 scripts/coverity-scan/run-coverity-scan | 59 ++++++++++++++++++-------
 4 files changed, 87 insertions(+), 17 deletions(-)

-- 
2.43.2


