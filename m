Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4148EF41812
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdxe-0004Xp-Ui; Mon, 09 Mar 2026 13:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzdxb-0004Vl-Do
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzdxZ-0002lq-9W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773075599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ez5UR2ePTDbtpiSbx35vmK6sFKy8Iby6tf/JB/RmZTk=;
 b=G4y7jeclX3+gOnsQxQi6IHg4lyctooFTtK79CkdZiKRRNN0LWA7Dnt8vyXXyRhtdxHk/6j
 0cjX7i1iS9fPUrbuKAWMltaINf7jNiGcriu/P/3B6I6FyFxI9zngfAx6bo0tC1PCswFeVg
 cARH2ehhHWOzdXMLo3aCJvnfWCz6PXY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-zIuV1wUGORS6BJDI1U2mjA-1; Mon, 09 Mar 2026 12:59:57 -0400
X-MC-Unique: zIuV1wUGORS6BJDI1U2mjA-1
X-Mimecast-MFC-AGG-ID: zIuV1wUGORS6BJDI1U2mjA_1773075597
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5091dfe4263so79719941cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773075597; x=1773680397; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ez5UR2ePTDbtpiSbx35vmK6sFKy8Iby6tf/JB/RmZTk=;
 b=LBGttzNoBnf2R+yPXqxLbT/4LfRaSRYxEE7H7I6hU0BhVT/CKRy/yPQvmdUR4kFpU2
 sv7JDVOtbvoR/25xy8CTenmgQyBR0vTXNCVJg4jNSx3/Eh1I+vOAElHw/H+3XVnNz3AG
 CIlEPy4KjIqQw6GWeIWptkw5aFBOTOUlCCOMHscWY7tYWN6fhV0X0pI8piGkldmjrgtg
 IDYeQopK7INpGdv0EnOzRgt8rpuggN9pmwiwXRwrTqBEzqEjBKQnnplSzh+n01RqpqYV
 948ExJjBhT23G9JCSrWIn2VRZ3ZhtgQZ1DdT6qildoRFjAUlXSiAExeT8E/Tv47KJyOd
 31Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773075597; x=1773680397;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ez5UR2ePTDbtpiSbx35vmK6sFKy8Iby6tf/JB/RmZTk=;
 b=ZUOGYvgivfClpxKjvAGy/S1yDQ5uext1J+1G69vyFAHHeAaqfJ3DV4TBtAmGOiUVad
 Zv2Kq3FhITX64BAHBcArIVDuPokpxw5QavHrUIN2AksrJNuYZyda0jGyu2Ag1pYrNQEi
 Ag5YAiAtXoLYTDVGSF8+kq234CQXtbDNIMMcUY64a9Wvqqkcdhjyqujeg7ETThsskzVR
 2xU9jFdrYQ2xK2JLeBEKPfRnt6Q20nUSyhGaa7zPpkFkpAmosw0zjU6zF1U7EDwy2YdF
 Sd++LdqIoGXdW/KoR3vgmHx7NfL8rx2ApxM7h+KJZI6peKceErC9j2oHXmUllC38m3F5
 /8gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSTqAr/E0iCtKedVTekliLYpYWLTwPnfl1QkIIpM4As/XlkO6V7IhBnM7C9mZrjdGXc4ZfsecYbL2X@nongnu.org
X-Gm-Message-State: AOJu0YzfAP46xFxIo5zbjHFqEYX1zgHAdbBPyqQMmyZzJWissITb9AtU
 w+qTT/lsENL7DwckIW8QTd3Oefi+NoC8Ahv8gnz0yBbK2nujBDd+36kY9FAZvFCdkgkblHYUx+M
 tss0x/EUWHTUv8mrzZ5wPFYb+bXZ9TugdkFhpFxDznlaS74q9el7wCpmZ
X-Gm-Gg: ATEYQzwSSATnOSdSe6ek5bAUvAFPfq7uUWDeB3n5HK+Z9jD/sLfzjsykCKolKTbNlpu
 cFUKGUDUpIH1LHWHGIeloiCriWAM/1q3eKjWEVgt8FxkzsmA+V4bFs/y1UvAjbIn89ir3YIJuQr
 q2OxlcXaCI2nPk6pPafyX21haJ+VS19jt1KfqKEvyB9p/6tOCh7HXOCL5eMlUjg8Nb+yIRTsefa
 Crcp54eD0f0xVWA1gd9OCMGx9Mh38Q/JQu3nRey6bNkoqUHeQHC1j7XDAEBYt9FAN6MtpFBa4dw
 v1TK3WRGQO4tE/Ya9ykitAxgOEJ5ihIGgDdNWN5O3oSRDob3xav7uRt/MQCrzT9NXGNPU9LsRMe
 0t06bTBPAHSD7Sw==
X-Received: by 2002:a05:620a:190d:b0:8c7:139a:bf66 with SMTP id
 af79cd13be357-8cd6d4b4e6amr1595594985a.50.1773075597267; 
 Mon, 09 Mar 2026 09:59:57 -0700 (PDT)
X-Received: by 2002:a05:620a:190d:b0:8c7:139a:bf66 with SMTP id
 af79cd13be357-8cd6d4b4e6amr1595590885a.50.1773075596675; 
 Mon, 09 Mar 2026 09:59:56 -0700 (PDT)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd81aa2eefsm365073785a.42.2026.03.09.09.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:59:55 -0700 (PDT)
Date: Mon, 9 Mar 2026 12:59:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <aa78gMsQrt1BeXt3@x1.local>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
 <aa755Yc6t_bBzM_u@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa755Yc6t_bBzM_u@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 09, 2026 at 04:48:37PM +0000, Daniel P. Berrangé wrote:
> > @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> >          sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> >  
> >          /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > -            sioc->new_zero_copy_sent_success = true;
> > +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> > +            sioc->zero_copy_fallback++;
> 
> ...this is counting the number of MSG_ERRQUEUE items, which is not
> the same as the number of IO requests. That's why we only used it
> as a boolean marker originally, rather than making it a counter.

Would the logic still work and better than before?  Say, it's a counter of
"messages" rather than "IOs" then.

The problem with the old code was we may report fallback=0 even if there
can have fallback happened, as we mask that fact as long as one zerocopy
happened in the whole batch between two flushes.  So it seems this (even if
the counter is not per-IO) is still better.

Thanks,

-- 
Peter Xu


