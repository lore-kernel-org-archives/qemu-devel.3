Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920A8D637B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBK65-0004sW-72; Wed, 13 Nov 2024 15:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBK64-0004s8-2z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBK62-000074-Im
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731530172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8q44WZ6lIxTIDoLIOLKs5dNG5o1xFmtEiKSN2lFAKs=;
 b=gbZxTEebX7/JpfRmtgsN2PW+60o9rAZ5J2wFOj+7dNCcz7SYGhoQDMEeiC3yVaa2Bkm5t6
 LKCpr0t3LxBAPGMDRt/1EFgKWBWYmdN9+uOBAZzN6hRTXLPiepzs76xQhx28V7OzFFW3SI
 BJHaVV/KiF8D/S9Iwi7ya62u5NZYXFI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-aorEr7zrPtm2TFo_dJVhyw-1; Wed, 13 Nov 2024 15:36:11 -0500
X-MC-Unique: aorEr7zrPtm2TFo_dJVhyw-1
X-Mimecast-MFC-AGG-ID: aorEr7zrPtm2TFo_dJVhyw
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-718183b6ae8so6099707a34.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731530171; x=1732134971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8q44WZ6lIxTIDoLIOLKs5dNG5o1xFmtEiKSN2lFAKs=;
 b=lFzmfQxxFVh/7YzwWmwnUhfu80UQ2wkTABnS7z2nQGxRiOrxTY50FoY/N6vXkF9SQv
 F9J9d1/tiCw+dLNN+GNRBEuyouwyNj2vl79Bsbl1ya65ouEwjDeirUU+ZYvVEypm0aWJ
 jiUO8kn6S02tomd2hauDUnb1h/PrBfREzSu7tRm9drKKubqZg9k2IgAXCStVZOglXnf1
 6CQfUdJZM6v8ma2DrajlESgAVuoGnxac+YZE37YUnUuprjs5NGKv/UGP/W00PplfFV3m
 qo03bS6/GThUCV0gY3Ntqp0D+wEWUenIQnCmyMYC15OqDrjPcbbrXuDlUAAIdV3Gobyd
 1A4g==
X-Gm-Message-State: AOJu0YyWLIdHdSJDReFuxqasaOju4FZi2y42H4ToZHG8xnqJ4PhenVsm
 qNenUkrjtMQjxF++1YKgvXoBOFlxp8ObjylL6fssEV4e6AvC+ss0kVupodujmntLXyjPaQrnug6
 KmsnTVFTqD+S/IxOi5L/IsrGDvHXoH2ofJ6IlAYn401NZESTMt5yz
X-Received: by 2002:a05:6830:4184:b0:718:678:56e6 with SMTP id
 46e09a7af769-71a1c1f1ff5mr21447969a34.3.1731530170826; 
 Wed, 13 Nov 2024 12:36:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGocy6+K5EPlKYCTRHhnalzBEBI4Iv2UnE3ust/1hmJB7b05AkNhZdGg/JNXWDaL5yT8qcD7w==
X-Received: by 2002:a05:6830:4184:b0:718:678:56e6 with SMTP id
 46e09a7af769-71a1c1f1ff5mr21447933a34.3.1731530170364; 
 Wed, 13 Nov 2024 12:36:10 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de78763ce3sm3009689173.71.2024.11.13.12.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:36:09 -0800 (PST)
Date: Wed, 13 Nov 2024 15:36:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 02/16] migration: cpr-state
Message-ID: <ZzUNt38DfU_Pr2To@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 01, 2024 at 06:47:41AM -0700, Steve Sistare wrote:
> CPR must save state that is needed after QEMU is restarted, when devices
> are realized.  Thus the extra state cannot be saved in the migration stream,
> as objects must already exist before that stream can be loaded.  Instead,
> define auxilliary state structures and vmstate descriptions, not associated
> with any registered object, and serialize the aux state to a cpr-specific
> stream in cpr_state_save.  Deserialize in cpr_state_load after QEMU
> restarts, before devices are realized.
> 
> Provide accessors for clients to register file descriptors for saving.
> The mechanism for passing the fd's to the new process will be specific
> to each migration mode, and added in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


