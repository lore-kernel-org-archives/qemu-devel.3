Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C523BE7E0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 10:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplEw-0007by-1n; Tue, 10 Feb 2026 05:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vplEt-0007ZK-TR
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 05:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vplEr-00083H-UI
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 05:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770720299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXVl8YNJim+B9QaM/E0zAAZWvvprDwFXsq6EdyQQHR0=;
 b=gUOxllmeT0BFWCvZQ20k1I6WCKnyqghwKcsp+CGV2V0/4XhM1i4gnjiZb5k6tBGHiZWmwh
 XsM4+cmylUXH0oKNz5kqMBB/W+ROOVo9P1OmQOq2c3fxQPKy9sguH4hMP5X+7p/eEfJhzW
 YJNqwTDSPrxKzRX7XHuFB03icYm4+68=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-IhhSGZjRMnK3zE2zuLEevg-1; Tue, 10 Feb 2026 05:44:57 -0500
X-MC-Unique: IhhSGZjRMnK3zE2zuLEevg-1
X-Mimecast-MFC-AGG-ID: IhhSGZjRMnK3zE2zuLEevg_1770720297
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee33324e8so9243465e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 02:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770720297; x=1771325097; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iXVl8YNJim+B9QaM/E0zAAZWvvprDwFXsq6EdyQQHR0=;
 b=YoH53BScw/ywKYWeFzSosF/ibzGuXmWS4BmIDrPzF494/J60uX0115J/BwU8qDVrPT
 K7DeLSPc776Cyq9uHEZt3zRs91h7dork3SoU1L7jWgXzNvYsWvBF1Snu2vMLsUCCea/I
 vJfJwDZSbKsw1KQPdBlBPgLERn/s25rWQorH96ydo1w+gHI6PbtNVbHstuNXJg+I9HFi
 jilib5nx466ekbiSe+UO3EZeGOdfiqQ0Z74BqWgudkirOK9W+VJrigPqcOLevFEcP2PD
 uaEcOU6mS/D3UJ96cOqYljKKtZ+aHYxtKvTRKb9mx3f3sOqvNzPmaIrCHrJFSYEhLjWw
 81OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770720297; x=1771325097;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXVl8YNJim+B9QaM/E0zAAZWvvprDwFXsq6EdyQQHR0=;
 b=TplOTr98MVdbWN52YjVHSmlpAC6AvztZKXlZljqCz9tn6pGPoCWDaYB/f2oFtb1+Lk
 vSCn/5wIIig3A16kB7oMlx65JNbzwRNMct8YzaLJRP5amP+4WtvH8okeAkgjaWpYk8hi
 YQUVCCLN5j6UGsvj3iuSL4/8qgpkHmgfnOh2zQXrA8s14M077G2oTDfq1wOLJuD0dl6R
 UoDMMv6oxu8U+rIM54nsoT2/iuv7puXxlzUi3yRAjBP/TM5PDZ4a7isPGoc94MGzSQJd
 FA5Mg6q82vjCr5ZYp/j3zEKEi7spUrVcwQyeWQcIHIbiATQ8O2q9RanG39hYaiFk3KJa
 P5IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrG9Y+Is+DrKv8dIK6KCxUWq3Vncc43h4KFK+e6UbrOfTFSPwSFq+4U6LAWECMdeWoQLKSsCPgJGfL@nongnu.org
X-Gm-Message-State: AOJu0YyOaV+tfTm/vBQy/GtrolGwux37aH4RJc73QrfhTs5xC3jLbMvZ
 n2TkDo4mOoG2cbNx2icX+VPP64LoK2umw8EhMLJzA6xp4khL0uXkSBfHbo1MshQb1sWk/1MUEYD
 QIuDEkgHAIy1BqjKTiRvdDFum5XH8sy5F1ALvI+Z4ILSZ+S/4Tt5l9RnA
X-Gm-Gg: AZuq6aLVYznctcEu7yYK8c9DNYlsadpAJ1zZmrwDwPo5hXrTqBHYLO1QRjqMWAL267Q
 7fVc0cWlF5EtW+vmJUg8HqFr0ruktdFQak6/DuyAS73e0hnrSYSoWhITmza0sPAd2KBTUoqsEdw
 zfMgZy+r8HT/VzIuktDqngmbm3uf52amZl+zI+MtwKMsqoc5UqGf3jK5/9icY25Vsu7wDPXv1Rq
 JVDX2OQawiBsTxs1alW1l01touQRA6RVprsWOuvTOiUnKnVn3P+lu87HpDOMIppWujlyitWm7ku
 wxPwonUorjPLKRhVj7vpo4qSiSCLb0S1P5zRbV2jrQJn80CsaJRxynPp1V/40utLrXkoRaraFSM
 fyF+kJ/llS3IYxlA42GmF8JGR9wLUA1au1r7FsgZ9dl6Huw==
X-Received: by 2002:a05:600c:6214:b0:483:887:59b0 with SMTP id
 5b1f17b1804b1-4832022ff38mr236998465e9.35.1770720296473; 
 Tue, 10 Feb 2026 02:44:56 -0800 (PST)
X-Received: by 2002:a05:600c:6214:b0:483:887:59b0 with SMTP id
 5b1f17b1804b1-4832022ff38mr236997975e9.35.1770720295991; 
 Tue, 10 Feb 2026 02:44:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm54863025e9.3.2026.02.10.02.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 02:44:54 -0800 (PST)
Date: Tue, 10 Feb 2026 05:44:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <20260210054244-mutt-send-email-mst@kernel.org>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYsElqDoGXQ_xMBD@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 10, 2026 at 10:12:38AM +0000, Daniel P. Berrangé wrote:
> On Tue, Feb 10, 2026 at 11:23:27AM +0800, Zhao Liu wrote:
> > Hi,
> > 
> > This is the v2 trying to introduce property flags to detect user's
> > property setting (from CLI/QMP/HMP). I dropped RFC tag since previous
> > RFC v1 [1].
> 
> This says what the series is proposing, but IMHO what is more important
> here is explaining why this either desirable or appropriate to add as
> general facility in QOM.
> 
> The idea that code should take different action for a given fixed value,
> based on whether the value was set by the user, or left on the default,
> makes me very uncomfortable.
> 
> There have been a number of situations where something that was initially 
> a boolean flag, actually needed to be a tri-state instead, to provide
> semantics like "On", "Off", "Auto".

But "auto" is exactly a property specific way to work around this.
With this, we could allow "auto" for any property (except strings I
guess) without per property code.


> This "user set" flag could support such behaviour indirectly, but since
> "user set" is an internal concept we'd still be only exposing a boolean
> externally, while using a tri-state internally. That does not give the
> full flexibility of a tri-state, because internally if we wanted to
> have the default to be "yes", it offers no way for the mgmt app to
> put it back to "auto".

I do not get it. Of course user set is an external concept.
It is user controllable!


> For properties that are not booleans, it is much less obvious to me
> whether we actually need a distinct "not set" concept at all.
> 
> 
> So overall, at a conceptual level, I don't think that QOM should care
> about /how/ a value came to be set. It should have no direct awareness
> of the "user input", rather it just represents the configuration of the
> system at a given point in time,  however that came to pass.
> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


