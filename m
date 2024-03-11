Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA3DC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmCc-0001Tj-Of; Mon, 11 Mar 2024 16:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmCT-0001S0-AN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmCQ-0004kD-5Z
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710188681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7llX1vNK+UPk1uzVDsH7jLHPS5/rtezpZoINm5/hHQ=;
 b=JO8i9hWn+C3lqKRLzvPeQaJqIDLk5LPWT01gy6MciMHS9YYpbyPSKQw6qqFXbhwGBKOozm
 72+zFzsFoiYJ7uWb+GCB6fXnPv7sGrUTKZwJv9gRpqhcKfE9QuBbzxk6fs233ccmFotKXa
 MrWdHP5WW+TMa8CIlFaH1pB20N+lyVQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-_2X-_1juNx-aNH2mWgTL6w-1; Mon, 11 Mar 2024 16:24:39 -0400
X-MC-Unique: _2X-_1juNx-aNH2mWgTL6w-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78867b1d0beso61216385a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710188679; x=1710793479;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7llX1vNK+UPk1uzVDsH7jLHPS5/rtezpZoINm5/hHQ=;
 b=k6BMsCg45AzvXbJpKYdiFEcBFX+R2f5naimQ/3NNOiY9EiMh2ZhYttEhFl8JaZ/OTB
 2UpM/RyS5RGVEmAfncEo44O6emLCqN7lnxP81VW18Ax18hc7gsStAtJJesNiT2x9cM1i
 5WEL3bxr66cEglxiUP/cvHd9kextUThYqo9ahfEAKkOphz2jOONBdUJ7XOmEMUyGffps
 lO/kipFZFadDXKhD9Kl1Ac2EQhnxMAcnShGwOwvkX0yFMfVQZqVEWMeo9PQ443ZQqwuE
 ENEASpx96PYfJKb2v6Rj+oqan8adkzHC6qTlqQdEiPPsKn7LZPL4waYMU4kasGOCnZOg
 GKMQ==
X-Gm-Message-State: AOJu0YxXEtbfuzcSrEjlQCgm6rmjTpYMprFF+pKY325Ljc/P//rIwPOv
 Nz7LOr3+2Wqm0lbH/bkPx0uNiBPoDtMqKXCRqe4SXpAGXGoF9T5FwZ5aQi3gm+r25F8WnI+jUPj
 1cbxON/UHMaVShDMfX2SQBcRSDpwPgRj4pwaI9cDm16EetYktuewe
X-Received: by 2002:a05:620a:4107:b0:788:72cf:394b with SMTP id
 j7-20020a05620a410700b0078872cf394bmr2671869qko.3.1710188679042; 
 Mon, 11 Mar 2024 13:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHwgFLrSAmMblmJeCmhT85CiOQ/52DpderPCyivxQpUUUrfgcyTKvaNEiTADiWWq2VXOX3QQ==
X-Received: by 2002:a05:620a:4107:b0:788:72cf:394b with SMTP id
 j7-20020a05620a410700b0078872cf394bmr2671855qko.3.1710188678708; 
 Mon, 11 Mar 2024 13:24:38 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 bj40-20020a05620a192800b007884db6b2absm3022130qkb.10.2024.03.11.13.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 13:24:38 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:24:35 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Message-ID: <Ze9ogyFZT73gB-La@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <ZerJDAdaakTCtECF@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZerJDAdaakTCtECF@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On Fri, Mar 08, 2024 at 04:15:08PM +0800, Peter Xu wrote:
> On Wed, Mar 06, 2024 at 02:34:15PM +0100, Cédric Le Goater wrote:
> > * [1-4] already queued in migration-next.
> >   
> >   migration: Report error when shutdown fails
> >   migration: Remove SaveStateHandler and LoadStateHandler typedefs
> >   migration: Add documentation for SaveVMHandlers
> >   migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
> >   
> > * [5-9] are prequisite changes in other components related to the
> >   migration save_setup() handler. They make sure a failure is not
> >   returned without setting an error.
> >   
> >   s390/stattrib: Add Error** argument to set_migrationmode() handler
> >   vfio: Always report an error in vfio_save_setup()
> >   migration: Always report an error in block_save_setup()
> >   migration: Always report an error in ram_save_setup()
> >   migration: Add Error** argument to vmstate_save()
> > 
> > * [10-15] are the core changes in migration and memory components to
> >   propagate an error reported in a save_setup() handler.
> > 
> >   migration: Add Error** argument to qemu_savevm_state_setup()
> >   migration: Add Error** argument to .save_setup() handler
> >   migration: Add Error** argument to .load_setup() handler
> 
> Further queued 5-12 in migration-staging (until here), thanks.

Just to keep a record: due to the virtio failover test failure and the
other block migration uncertainty in patch 7 (in which case we may want to
have a fix on sectors==0 case), I unqueued this chunk for 9.0.

Thanks,

-- 
Peter Xu


