Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7896D637D6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 21:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVd3Y-0003y5-Sv; Tue, 16 Dec 2025 16:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVd3R-0003vA-CK
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVd3P-0005gW-S3
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765922279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hUMS83lzo2GFaT9sYxcavmQIbMPhlS2iEK4CCshmP4=;
 b=bIBuvsnY4tjydjRHAJMqP01MOLy1Rf37CdzDuXTLnKzs+tFhlTw+DbbPXVBpKsz7fmg5PM
 3xKCcyaNCnF51V20m7fbzDX9NIBGrPfAkFV6ygtDwdkbaQzZc8m+xLfDFt9RFDRIePS9dR
 CNA5oxeD+PGg7PueNwOjKTN0SP6TPLA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-ujwG3G5WPqiOAaWqBmNLSg-1; Tue, 16 Dec 2025 16:57:55 -0500
X-MC-Unique: ujwG3G5WPqiOAaWqBmNLSg-1
X-Mimecast-MFC-AGG-ID: ujwG3G5WPqiOAaWqBmNLSg_1765922274
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b99d6bd6cc9so10236639a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 13:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765922274; x=1766527074; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6hUMS83lzo2GFaT9sYxcavmQIbMPhlS2iEK4CCshmP4=;
 b=Xy8LKXEz8Yl7+NF8KHKzk9M/jzEqR61ArSFBUsko9138KkDSbSco9UZrd0cwKPVg8u
 Wxj6eEnzW07Le+4qGt+68ayJi0omf5vMk/TL0ZggxTdajs8iGs0kelrzjX7tx+bzXEu4
 VTvbOWWCVGaZXI1uvEJo3ocB1TL7Zk0mL+5SgRRVGIUpECrqdCgKsjVuTfuZZoL4pBwZ
 Sj2nx/Xf/bTq2UttFK9vkRYYhEqI9T0ybvPfxMTGCyndU/hNS/RPNp8hFkzBiMmHuHYT
 0317h1YBeI638SAhSAGPURXRPBmqNZoTcakFTJ0b23yOhtFHflLPo/tiVh7JL+GaqdN1
 upjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922274; x=1766527074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hUMS83lzo2GFaT9sYxcavmQIbMPhlS2iEK4CCshmP4=;
 b=TVtx8pjvBzHkYPvSQ3K0EaWyYOZCzrHaVegvA2Cv9ubyYmeQB1GDPZFh9WgPiv2gI9
 MVIY7OUnN1rYmukvi7RyWgPCwjuUUbr3fjIvsrqjehmt7Fj13oNUZMJbpvv+f6NPM6w/
 mAyUuPvsARkrGgnpWI796OB5qRYvNPMgervDem6bmzcwmJqAHG6vFzWssVgAizA5w3LS
 PpFUbzkzvYBljsIZPdilR6xKjEgcsKMUwmwzvpJuquRN6OEnt+gPCiY/qUM+2fPVXHLN
 Mn21nWgRkF3RPsUlrWRbk2A0xlKndcehBPiM0HLCXdlUUVOVSrHpcRzNKGTZX1BQuAkT
 wlbw==
X-Gm-Message-State: AOJu0YwGGmMDygvo3kgnC6QT6bbBdzYJuytPMyHMHZ59x85djFLk35Bv
 8s0fHx45LSN42cfEV6nRP9WiDFPdIAaXyIKEvxpvmLYkZKqilBRPRvhxcjrVWS3f/h71GtH8Urh
 ks7JehCMS3CXBBdbauO49104gUCCbFZ88Q8dVn5AfCD0WGYMz8ZngGEQg
X-Gm-Gg: AY/fxX4xVrAaka4QYhtCaUiVHvHWJ0vvzXjw58otVNc9BaMgBpCQkt99uqUf7Qsm3/e
 shdG6pu5Mx93q7+7gF5MefuoL2rxfJGC1Qq3WgUpisZUbxrDgBhQ1ycRLKUTUbwGFoMly6aaq+j
 TFPsGkJlmr7i9tTVdGtMziS3OD4V5g5SLTgsmYd7tB298SNE8gDp8wmMa/0kOxdtr0zL14wJSl5
 QFC7j7flx9wDFuJSC+UNw55q7oZzNQqnnAYcQxMAKKergYIABy3XQdGtdnctOCtAWwAye4vraHV
 nDOdgnWrE+m3U0GdmuytxpkQzzldmFKh9HrQX7QSDXIWUjqXRIZZiDch8efEYoemnVVnwzsWgda
 EDhU=
X-Received: by 2002:a05:7300:6425:b0:2ae:2ba8:f341 with SMTP id
 5a478bee46e88-2ae2ba8f7d3mr7750061eec.15.1765922274326; 
 Tue, 16 Dec 2025 13:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvqDo3XzND0WcZexEeU2HU3v/4yuEkKYGxM6shHjFEv4B7P6keBn6uFW+EXZKvsZBkxW4a8w==
X-Received: by 2002:a05:7300:6425:b0:2ae:2ba8:f341 with SMTP id
 5a478bee46e88-2ae2ba8f7d3mr7750043eec.15.1765922273808; 
 Tue, 16 Dec 2025 13:57:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f2e1bb2f4sm54366138c88.3.2025.12.16.13.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:57:53 -0800 (PST)
Date: Tue, 16 Dec 2025 16:57:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 26/51] tests/qtest/migration: Pass MigrateStart into
 cancel tests
Message-ID: <aUHV3NwgbjwLEyzi@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-27-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-27-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 07:00:12PM -0300, Fabiano Rosas wrote:
> Pass the "args" parameter to the cancel tests so they can access the
> config object which will be part of this struct.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


