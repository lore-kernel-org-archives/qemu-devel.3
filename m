Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CC606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMvBuWGO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EAblW7ol
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2jb-0003uC-NZ; Thu, 19 Nov 2026 09:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU2jX-0003qE-Ae
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU2jV-0000JD-OY
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795097002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIPrRTaYfEByF7GFeCqTE0gU7wr3NQyStaiQCd/OMtg=;
 b=cMvBuWGOOAh+S3YmCTzxLojJ0p1RLus0inwpDHKjiYZXFUA0sbH2SeVF4oiYPTiP+kpQ26
 i6oMeC7GAWS3XLjOcRJyFBft3C+q0VB+vHuwnlkM2wi2wzemYRtvgwbOgZ0pe4Lnh0Tj6+
 MGIh/AJO3W7wxGRTErQuShh1ZdDM028=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-WGhiK9CqPGKihQO6AxNcIA-1; Thu, 19 Nov 2026 14:03:20 +0000
X-MC-Unique: WGhiK9CqPGKihQO6AxNcIA-1
X-Mimecast-MFC-AGG-ID: WGhiK9CqPGKihQO6AxNcIA_1795097000
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d7544d113so3345011cf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795097000; x=1795701800; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jIPrRTaYfEByF7GFeCqTE0gU7wr3NQyStaiQCd/OMtg=;
 b=EAblW7ol9+eOmjHLi/Az6NtfKOLKOkkwx+uHjk8CQAoV0oOzZPI73MlFDTrY+A9DpJ
 MAFT4dede2q0VgseEsuIXVjRCa0macmHXrAImvnH8u/GtMDXAbQkKrhcaxinb5UfRncY
 STzC/iYpdwdKZqYPyemhUIaA+Pk6smMDgrNQe98h1z46qgY60RMKoupy89zqRf8Q6lT8
 dHHn3NlOkcKNkBqnpE1Uhn839lRbtCshCIEz3mlmtzERePD5qY07wavevBVyGrN9uodx
 sGvPkfCwiX6PaWqcCOIoa5yjUxDnwiDGhu0nF1bSEbPXrzLJeDwwFZ99I+oAqoxhZ8XA
 TraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795097000; x=1795701800;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jIPrRTaYfEByF7GFeCqTE0gU7wr3NQyStaiQCd/OMtg=;
 b=Bko4OJGwGwyKLdCIfgFWaRJK9lLX4N0iSybVjojKRVA6Xb4v0Qa5vb74Vqz7J+k/Sn
 dimk0s6cUDH4tC4zH8rY97FVRX9GQFhxMIfKMKoaZX+u7okdhTIw5Poo6LaHLWLPE68n
 aSdh0qciCZHWa5sUaI9waBgotg2uImndZHAghXGluaAVhJVVc5nDLHQ6Yzs2IkC/njTC
 6Sl5GmNArgEYeau69jqWmZaLNN8+13fHh0DB3kmAVuQ3SG58GlyJ3DV46BNw5cVYDL05
 m4RP+IscSsk6NCOOJXxScVR/P29+qrF8iSTQSf6MZMzs3ZmNR/3b+cTkwCeRm6uJZljB
 u/Tg==
X-Forwarded-Encrypted: i=1;
 AL+hErF7aD+qOon+Ek0NSu4qysxnnq3p3VyBOPjjr4Is6Qc5tQJQ4JTAfTn6W1XUcnPUswjCzYk6r92o07Qj@nongnu.org
X-Gm-Message-State: APuU4Z+lg2EsH8D0LjWyRZ9YPWMwMeARQ1r5QswA6orWfsiwmIfZf4uf
 /FGq/iCdq8ldj6UuHp3gVoS/N7nbKjawBain68z3UsQdR9KA7PCUG4+7Ei2fgKbqemSYBkjKvJT
 Yyat7HA9EH72WbTDUTaqR7pOW6/0cPlIBGws5eP7SgoS4jbgfw5OOruGr
X-Gm-Gg: AYBFou1Ljz8ipzMUI2MLSSTzz/xRYdk1htUAOYuW40y9OHMiDTDU6jUPNlifGZqZc9b
 e0pvMXZENy7AAtdohINv6RizRJg9+8ZYc2eNq8xtmVkk+Wa3hxrbSMDnRxnZVqPthAFxuls7YzX
 IVqNxlgcIXBuOROdydhpSXj5O7l7TgF1uPEA9AL6qf6vMrkBZuslSP8lLSDqO0enidbIpdc16Gx
 jfxsbmTv6Pr3UzW/iUDVBQ/FEp6lh2lRBDs5gtuMhUYoHi/vAG47NB61xgudOv6gtLBFZit4dnM
 Wwv9ZADtXCtZAxtEMpWQ7DDLhBQ2Pq6k3hmh/n87GT/+X6vL9n3CjZrNNpf8yjPC+oL1QqaPeHA
 NXME6w711fqWyE9MOnJLQ5o6jV0SfVgcbJrKqu5Syrtvm
X-Received: by 2002:a05:622a:2589:b0:55d:3540:5da1 with SMTP id
 d75a77b69052e-55d5a543552mr89319861cf.19.1795096999806; 
 Thu, 19 Nov 2026 06:03:19 -0800 (PST)
X-Received: by 2002:a05:622a:2589:b0:55d:3540:5da1 with SMTP id
 d75a77b69052e-55d5a543552mr89319081cf.19.1795096999100; 
 Thu, 19 Nov 2026 06:03:19 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d66c4ff96sm23852621cf.27.2026.11.19.06.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:03:18 -0800 (PST)
Date: Thu, 19 Nov 2026 09:03:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] docs: Add security considerations for migration
Message-ID: <av8BpdwwtgB2-q87@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260721131457.3062767-1-farosas@suse.de>
 <CAFEAcA9GDRQoqEXAt5-Mnm7jTPvpkZ6EPPvxiL7h_mFZOMuW6w@mail.gmail.com>
 <87ik2njjqn.fsf@suse.de>
 <CAFEAcA8vq-zFsou=A4H+XDZ-zsWKJK3-RzASs6aV_s9efFyQyw@mail.gmail.com>
 <877bj2j5lq.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bj2j5lq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Oct 28, 2026 at 10:51:29AM -0300, Fabiano Rosas wrote:
> > * **migration/snapshots**. The user must deploy QEMU following the
> >   design principles described in the Architecture section to ensure
> >   that the migration stream is secure. Plain manipulation of the stream
> >   is not considered to be an attack vector. This means that:
> >   * Migration failures and snapshot load failures are part of normal
> >     operation; these are not bugs as long as the source virtual machine
> >     or savevm file are still functional
> >   * Aborts, crashes or misbehaviour of the destination QEMU due to
> >     an externally manipulated migration stream are bugs, but not
> >     security issues
> >   * A crash of the destination QEMU that can be triggered by a guest
> >     manipulating a device on the source QEMU before a migration may
> >     be a security issue, if it meets the other criteria we document
> >     for security issues
> >
> > How does that sound?
> >
> 
> Looks good, thanks. I'll send a patch.

Not yet? :)

-- 
Peter Xu


