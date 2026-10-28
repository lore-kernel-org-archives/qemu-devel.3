Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1BD606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGKxKGol;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SqwndlyI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLy1Y-0005ly-4z; Wed, 28 Oct 2026 03:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLy1W-0005lm-0B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLy1T-0002Dk-3P
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793172273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjKIzg4DURX5JwuSS4RHjX9narjqVEsJDloXEia4pwc=;
 b=dGKxKGolRKJzElRN+nXx8t9L8iI+eWZGYXiJJApX0jKyzyiHmRtgI+JOB+3hcmbiaBzmuv
 h6gHJXhc5hgfUmdfxp8iPueAto8M5agxV9n39AoxF2CAfyc3xN+z2dcqr2hXHiSGwVJOxD
 Yu/1168St8aRXzx7jJxttWbLUKd3qIE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-JK5AgupDO7CJD-cuAfk35g-1; Wed, 28 Oct 2026 03:24:31 -0400
X-MC-Unique: JK5AgupDO7CJD-cuAfk35g-1
X-Mimecast-MFC-AGG-ID: JK5AgupDO7CJD-cuAfk35g_1793172270
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0fc747a7so471590f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793172270; x=1793777070; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wjKIzg4DURX5JwuSS4RHjX9narjqVEsJDloXEia4pwc=;
 b=SqwndlyIv5PhR8MawD6rhmAD+1wqfFvJuvmDnEIpk7kyXc7s8qTfGXWQxfS2cGsBTQ
 Q0QQ16fOwoDXhfkY7SWrIcjUUKU2gvnkLQU5ry5tVWwbpOHeZR180BioqwuhCJwwdlmU
 oHnHeZtxG8GybBBjZJ0jiQY4Zp2fMZoTS0Or5BbAOPrnB1zVa+QQcCgtQanUe3vrjme/
 He0QEPE/vBKpE3hmR3/MrbZoRZg06GGut0wXQDD/yAorBZPBtu1h8UVRRD+kwbdxuCwX
 N0gUIh7QpLtYs+aSPUu5CANE1Huykactx5SMWve9W/h7qGNNJVBtlYUgzHBtvkPYLujW
 g32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172270; x=1793777070;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wjKIzg4DURX5JwuSS4RHjX9narjqVEsJDloXEia4pwc=;
 b=ViBlDzMqA0Gfwz/qJ+5/goIWk8cHq0qjZtL3lXRFcYBjOxYnlTFpaYhx60wpusxWo+
 W1lj1HoPTalIGnYU8jhTPtK/Gp7OZrHGTxWI1erl6JrOUBuAlx4Up4UDWVJ8uDfRRriZ
 QtSux+boGLnSHetHxiIT3P2dm+4f+jMlF1f3EeoLr3blpoJamOE/Dk5Ta3pcDd8aJWVs
 HNkRBWPbTh89M3wpxCtnPeE47Nu6nM7ZkEhQQ5ZyKbI+BmE2x1zEK2D7TtKIY8PrcM1s
 L28mnxJZid02v29Myg2SiRi3yHjtOn/3zS5DVCLbVDJhU5Yhx0vcfL4VbH6YzxxiQ13O
 I/yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbvZOR1dLO07qA5XGOvOROHA3UJrYLMZDL2PKuXB1JHr/xKdtUiOLTn9bAozSQ167OQfeshnFZ4IYA@nongnu.org
X-Gm-Message-State: AFq9FYJJiGbb+pjVz8+B+k+xB+yL0pLwPgBbDCvUeim231uxHP+n5Xt8
 vC2AfnEgeoW8L1HoBQvDKJVUMRVduvF0DEOcIyneeP+dKBuqYXbMei7y57SAr6BMt7pdaoj/2es
 3K3hdxg6pW4H5LIWvTYPX4WkRnshpRyOhq40TcFaweXPnQ9ZuODuOU2nhHw7ye2g+
X-Gm-Gg: AYBFou3ssNkZcw4Cysw6Qfh1ZkySvYJbTlEAeUk6zRRaAAA2pcCCbNbKJChOUHY65gS
 EqKPU3bgjuO3EcVkZDxdn/DtrLdbf2wtdLMC+gtoON8H36y6F1IuuzWHuZ7SAFnVvdsAxlUBAzE
 v2OKlWUixBsjY56hip3mAyeoxjzLzFxOysDYWrdJj3O/7vAUnsJhPOEP8ZY3MBbgIYxEcH397Zz
 WA66kfh0jrFbuI8NPHxTPd2OgrMR+LcFfNa8//vsKiUbAs42+h6RWDantAnEA0x2HKYQ9xkD4k5
 GuWroJQZZWs6Oy03SZsHXgsYpz3EVD6koQK2Vki3lksddxEFBuzMkhdU3wZxkAQB71FCogWsmmt
 oq7qkbdm1fJYQA9pK8iLNI1Q6kVy06w4hrjCzMQTF
X-Received: by 2002:adf:e19b:0:b0:48e:3df8:74cb with SMTP id
 ffacd0b85a97d-48e5d45a44cmr4167967f8f.6.1793172270077; 
 Wed, 28 Oct 2026 00:24:30 -0700 (PDT)
X-Received: by 2002:adf:e19b:0:b0:48e:3df8:74cb with SMTP id
 ffacd0b85a97d-48e5d45a44cmr4167913f8f.6.1793172269597; 
 Wed, 28 Oct 2026 00:24:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm26832587f8f.17.2026.10.28.00.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 00:24:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 03:24:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junjie Cao <junjie.cao@linux.dev>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, jic23@kernel.org, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org, junjie.cao@intel.com
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Message-ID: <20261028032407-mutt-send-email-mst@kernel.org>
References: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
 <20261028021551.498530-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261028021551.498530-1-junjie.cao@linux.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 09:15:51PM -0500, Junjie Cao wrote:
> Hi Philippe,
> 
> On Tue, 27 Oct 2026 19:20:21 +0100, Philippe Mathieu-Daudé wrote:
> > On 21/10/26 15:43, Junjie Cao wrote:
> >> -R: Junjie Cao <junjie.cao@intel.com>
> >
> > Could you Ack from your other email?
> 
> Sorry, I've already completed my handover at Intel and no longer have
> access to that mailbox.
> 
> If it helps, this aw99706 kernel driver patch from August is
> DKIM-signed by intel.com and has linux.dev as author and SoB:
> https://lore.kernel.org/all/20260804030255.1934470-2-junjie.cao@intel.com/raw

ok, will apply then.


