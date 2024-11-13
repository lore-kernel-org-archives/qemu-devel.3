Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B770ED637C4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 22:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBLS0-00068e-Ga; Wed, 13 Nov 2024 17:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBLRy-00068N-3C
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:02:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBLRv-0001LS-I7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731535373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JTgRnEAY3u1fM4qM+Nhq8+xtGOz28NUHZ5UzCwTBqg4=;
 b=QxsNzrA1G58zdVK9srq6dF52gH9RlLJ7mRmg68dWyiq75PT+NIvxIR2nqOFNKv/qCA5ASr
 VO1IzKuHx+54HyF/pYiS8jY+fNvPS2P5ulJSYuR+9MPHe4OdVLQ5np+BJCCLM5OrrVoKKp
 gP5BIUqjV147Wg52EdSVSLjlgTTHBJY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-pvq6z7KnMkmw00Yzh3352g-1; Wed, 13 Nov 2024 17:02:52 -0500
X-MC-Unique: pvq6z7KnMkmw00Yzh3352g-1
X-Mimecast-MFC-AGG-ID: pvq6z7KnMkmw00Yzh3352g
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d354ec5288so102941656d6.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 14:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731535372; x=1732140172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTgRnEAY3u1fM4qM+Nhq8+xtGOz28NUHZ5UzCwTBqg4=;
 b=T3J+bLdGDgEyHoJ3maacifNhwnJ5J4i9wpKMBfcnI4iY7U8J2CX8p6YfmwDfqdRPeb
 6OPmqCrtp/uS2kWEbC+ILZp5AxaD99ANySa3EhceXmheFc6bBUXiXTzIOu7d8lbf8Tct
 oAYVf7uMxSdfmwrmqDc6icISb+SN55FTkKw209nhQwWCDRivsqtMkbBCGL1z4swwbsNp
 eX5OZq0+GrmyOLPPPGfuGzLuGdHhiCQDuDpb04ASO9RIIqTEj+QgCPF+zL9v4B52qbDI
 9wsChB/tgOzTs7gNrn0Z/oB1K6fXrOuOWq8hqMMpjP0Ve7vBbgiGItzoEEgipeJarzMR
 CYFg==
X-Gm-Message-State: AOJu0YwVCawZE9tgUNMgtJqhgxcgrCJ1yefDSQ0cUHF/JIN1oGRnfHLV
 DPRvZ2qkrv24jTJ5Khqz9BZqajDZwnO2YENxuMfoaosPNDm6yKlNlWlm1e35vb5TOZQH/QMtV/I
 rmWI4bNJOKZWRQbY4LGxR790CRZJa3jWw0sdBGy8HuQ/f4eosHocy
X-Received: by 2002:a05:6214:5782:b0:6cc:37bb:40b with SMTP id
 6a1803df08f44-6d39e1cec3amr302701876d6.37.1731535372133; 
 Wed, 13 Nov 2024 14:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeNgpswLXrM8Qs0CAv13yjabkn/EnyANKT5+eWDnk2WjCAWjWUaHGFnkbhQUC1frlqIch08g==
X-Received: by 2002:a05:6214:5782:b0:6cc:37bb:40b with SMTP id
 6a1803df08f44-6d39e1cec3amr302701606d6.37.1731535371865; 
 Wed, 13 Nov 2024 14:02:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3961ecdb5sm89347936d6.36.2024.11.13.14.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 14:02:51 -0800 (PST)
Date: Wed, 13 Nov 2024 17:02:48 -0500
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
Subject: Re: [PATCH V3 16/16] migration: cpr-transfer documentation
Message-ID: <ZzUiCOCYEaaF0cWE@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-17-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-17-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 01, 2024 at 06:47:55AM -0700, Steve Sistare wrote:
> +Caveats
> +^^^^^^^
> +
> +cpr-transfer mode may not be used with postcopy, background-snapshot,
> +or COLO.
> +
> +memory-backend-epc and memory-backend-ram are not supported.

Just to double check: now the plan is to allow memory-backend-ram,share=on
to work too, right?  If so, here needs a touchup.

-- 
Peter Xu


