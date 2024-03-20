Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86316C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzur-0004hw-Ft; Wed, 20 Mar 2024 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmzun-0004hi-Jm
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmzum-0002Nu-6g
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710956386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LadTrEs32q6JuiUng9QgE0IesXnTjqGpv9qfMYEDVbA=;
 b=NGSt1YyFQB0yWpKGR3oh4O/N1xt2p/YHEC8Icy+jILdN2VccPUTDeR92+hGWX1W6P7Dkhi
 e8Fzq705RHrqy33pmmHTR1Pzw+Ctyg6+QtcUIRgUKeIpcjQPcdCcWn0BTCSalobhrkvIKf
 gduSB83EufGenWo5E3vUSTxO5DXe2Dw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Kps6Nz2JN7KXf8tagPnJFA-1; Wed, 20 Mar 2024 13:39:45 -0400
X-MC-Unique: Kps6Nz2JN7KXf8tagPnJFA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4311dd10102so244281cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 10:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710956385; x=1711561185;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LadTrEs32q6JuiUng9QgE0IesXnTjqGpv9qfMYEDVbA=;
 b=KtKkLpQG1GEk76C8W5ADnzheEPS5paGSoxSUCZQGYSY6gV9hXrk6KaP59J5YuLMEKN
 ZjDzLytcy8VkdU7vnUwOmnZ8AH9KdD4boOtlVu7olPmfgLJaRmHdT867dNmrUlIihoiR
 wz51BQMUU3YzAiDWjwDk0et3GnHScI65u9s212uoq1MhxOm8Y1pFEd9fzHve+RjXSd8V
 uNXAiDG+ZTHh50Mj8v/NJ+CyNiYan1MIKkCbYxmo6pcofqJ7GvDl91BMCmi0vKIVWxdC
 icrBox+LVPQUSyWuCHDpcWru6nOT8N3QSP7iTPi5XcL2UVqKqiqE/K9RWZ4NDnJ2SpI0
 qutA==
X-Gm-Message-State: AOJu0YzuA3EUcswI6WjvlINgvlrcI3co7FMbVL2KFGmIB0wk1e+b3wH5
 Yo34lYiEAhXPAT/MpCYt5ihp2VwaPJfaYf1xUNRWbqLW2pOx45+4Xy5+EO7oOqktpb424CRlhMY
 iCg51I2CsK8sHKkZyLHF/jANOHDuz64D/kGzhP/4zoEc6KKDyF329
X-Received: by 2002:a05:6214:3f85:b0:690:9db6:f410 with SMTP id
 ow5-20020a0562143f8500b006909db6f410mr6764872qvb.3.1710956384656; 
 Wed, 20 Mar 2024 10:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLZ2jRy2HZB5vFRERmbsQfn7UkuWfj7vRUfuSEG/rE4h7BJgEFptrr/T99J5Y/I3ZjhMxHSg==
X-Received: by 2002:a05:6214:3f85:b0:690:9db6:f410 with SMTP id
 ow5-20020a0562143f8500b006909db6f410mr6764835qvb.3.1710956384209; 
 Wed, 20 Mar 2024 10:39:44 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 jn10-20020ad45dea000000b00690dd47a41csm8107560qvb.86.2024.03.20.10.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 10:39:43 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:39:41 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH for-9.1 v5 09/14] memory: Add Error** argument to
 .log_global_start() handler
Message-ID: <ZfsfXX48CEV5IfiJ@x1n>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-10-clg@redhat.com> <Zfr10JG2dTChsLVj@x1n>
 <d58d5134-dbfb-4c07-956a-5e8f3e230798@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d58d5134-dbfb-4c07-956a-5e8f3e230798@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Mar 20, 2024 at 05:15:06PM +0100, Cédric Le Goater wrote:
> Sure, or I will in a v6. Markus had a comment on 8/14.

Yeah, I can handle both if they're the only ones.  Thanks,

-- 
Peter Xu


