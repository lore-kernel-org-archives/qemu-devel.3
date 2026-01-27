Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCE3D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 20:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkq0S-0007tj-FL; Tue, 27 Jan 2026 15:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkq0M-0007r2-UN
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkq0I-0001jm-S7
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769546977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9TBp3iPXeEZRpjEhBsJ6INFCVSfLK9dygzurhhrN6x4=;
 b=YFssdkOLzFkNmjhmSZwgUBtymN/avvz+11NTMRcoSP6+fOL2p0N7A4GuPDZhLiVweZFkYx
 l6MP+7ZRyKZX0lkbD2av/PH04VNyAX/iNLmuKbvNZHq5emwfUmzp07n8Zt+ZOtbJ1MrIFz
 DfvUHMgjYPdmquqJwZbOk98t33jDD7U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-T1sJqkFbNZazNpa2EvsQ-w-1; Tue, 27 Jan 2026 15:49:33 -0500
X-MC-Unique: T1sJqkFbNZazNpa2EvsQ-w-1
X-Mimecast-MFC-AGG-ID: T1sJqkFbNZazNpa2EvsQ-w_1769546973
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5014ca48a56so276762731cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 12:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769546973; x=1770151773; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9TBp3iPXeEZRpjEhBsJ6INFCVSfLK9dygzurhhrN6x4=;
 b=o5mu54PwMm8+9/weIpAbBZDSpS8lSbbK0ppg0PJIfuTYYquxV/LD7pZmFBXJy3NIsB
 513Yljg0vm3VyiPwNyC90lWuOKkxfb/LF3od+0+u4T2AHbNmf/afOHPblX0X11EXXqoW
 5NdQqqv2qPn9VpEEbNjcEiMDrhVSM8cW+a6DCyllp3wGdOTmKz1mlhQcMikkJnqeluc6
 kgiw+79UcSevCcauhJKFv4DD6ro8h2+wgmyWM3HqEnSEtxm2p5ym6iOw86nbCCVSSY2/
 7t3CKT/FyZVvRARR7miDCGnM6NWJfwdbSniW3A2XMmx+8EfZwD+xXcyJeDue9SexO70s
 IvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769546973; x=1770151773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TBp3iPXeEZRpjEhBsJ6INFCVSfLK9dygzurhhrN6x4=;
 b=WNBguxd0onJbOu8QWbAQkfW04LP7EQ9iyysLOYRz94GFZmWpri5099gqGnALN00KFg
 eSH+z/UIE7ddJKZL7ZR9yb5AZJRakSKK1PvQ82FacwLxiY6nPzfDnGFxtoY07O/R9ymn
 b0hYBeu3z38W7paKJabPYi2W19J5vzT8SOwwxnRYLsFGsqyffCI2ZCht9PhJRgTyUFs6
 gZVyFbp0UTInEucqib6Ch2xNPO84p0tA83/C6jTHrk9DGkRhXlX0qrnRBJ10eTZn10qc
 jnZ9CCxAcERYL0qjl5g29v/OkzSTx+djkWth6WEPnGWW0+GjWsf3ckN6WqdKG/HDtXZ+
 Xgdw==
X-Gm-Message-State: AOJu0YzF4EoUpHiJfLFS+kwva5Gql23mJ0I8xZtVbRR/3iqLWaAFJDxv
 u6SHCrlCqqE6BdMd3V+kHplhFB3ekI7vT8Kqe2KMJuaNZsJxkqmzmo86XL8+fhySVz5p5ucS9ij
 /pA7v+0k4Qj9oUn/K+gcLCCb/l9Ppvcu3TlCgBIfmodRFHTa1Q2jeEgfF
X-Gm-Gg: AZuq6aJ8lHPMkJCknzcM1q1eigUb1IbvSiinplb1IphySjKyK/uzOSTq2hARoTL8JZ8
 B7mbu2u8FwIo8OeedjGBrCbZ82Vn5LErS2LRtD6HVecYQxeQMXL0r4wgtpWLpjGN4b9gRVwIsT+
 AuSsunLbw0GMV2ocKDARTfgPdWeoZCVs2cpMdl6qFs6wxgQ11qBVcQmy1DnmB9rWhteQnQs2F7H
 FCJUNvXXiiSb2KQoF81EEKBX59tW3FYWQMO4UD0xDTnVfg9R1AXpQ/cQJVAAIqm84YTMFgG9428
 xfGgk0Xr5VJOkYlSQ/RghL/ihTrrkEgar3G6OvYUYGk5uTuziu4xwMaGb5ZGIBlBdiaLLQdLp5R
 +NSY=
X-Received: by 2002:ac8:5848:0:b0:4ee:26ef:7f4c with SMTP id
 d75a77b69052e-5032f74b063mr34233651cf.17.1769546973137; 
 Tue, 27 Jan 2026 12:49:33 -0800 (PST)
X-Received: by 2002:ac8:5848:0:b0:4ee:26ef:7f4c with SMTP id
 d75a77b69052e-5032f74b063mr34233361cf.17.1769546972769; 
 Tue, 27 Jan 2026 12:49:32 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d373fe92sm4137426d6.32.2026.01.27.12.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 12:49:32 -0800 (PST)
Date: Tue, 27 Jan 2026 15:49:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/10] migration-test: Add COLO migration unit test
Message-ID: <aXkk22x1M0k4qZoo@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jan 25, 2026 at 09:40:11PM +0100, Lukas Straub wrote:
> +void migration_test_add_colo(MigrationTestEnv *env)
> +{
> +    if (!env->has_kvm) {
> +        g_test_skip("COLO requires KVM accelerator");
> +        return;
> +    }

I'm OK if you want to explicitly bypass others, but could you explanation
why?

Thanks,

-- 
Peter Xu


