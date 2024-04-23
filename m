Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB033C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 09:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzChl-0008CR-0V; Tue, 23 Apr 2024 05:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rzChj-0008C9-It
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:44:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rzChh-0002pa-UN
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:44:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3465921600dso4841766f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713865484; x=1714470284; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/5YkfIclMRXJBQ10DhHZv4dvYuxXj3Sb02ci8s2G4Ko=;
 b=D71mxR3VCVVPorBAk18cR6zkg6cWIl+Yuh/Xqt+xapHOSw5grWbxht+yLHueqbqcL5
 z/JsVtTtyUTVHi3/M0Tv9W1pZDosEJ/SFzoWCP0YDnLBui26Ajnduff3SISjzyBVvG+n
 jVMaC+UUT6glk9ZxGE0ZwEcumNMk7rJL25ZlXipVWPdQAdlBDzP8bKZ/TtWWp4XUIcCm
 L10PwjZ+SZXQd5thC+/J7l/hWc3izKkxGMlU1KRVkxnGTCBgoTIvBGL0eYWfXLGz592t
 IK+b0yresdkyGAs8jhE0Y9loFEkmjJoiAX8Auz2cq90fEoQaM/XcY9tykCisQntCgHfe
 jsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713865484; x=1714470284;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/5YkfIclMRXJBQ10DhHZv4dvYuxXj3Sb02ci8s2G4Ko=;
 b=PyGIfoYcFnZlGQrgouNglgAdcFvq9s3EfAuvI2AiSSL1WkfNxE7+rCTy9bcpCJu4ZA
 +3uLQbjcAoTfJgGY0+hwi0F1D9Qf+QxEN+cjXgGNw2KoFdR9VP/+0tFxCysgg5TRn9iF
 kOmdPh5nOvRqCXLiLAjSOc1hyy1pKZNjrRRabRjlHttEy/dkbnE8RhBIu2xtZKvhw9qd
 rT2W1pApkYJIM7jsJWclp7IW7A0gXAmylcV7hZE+vUiGjXW2aVS78GpLrj3Gb8ILIUdA
 qzJly9T7LcFZr/ARut+f0oRoL1E0NC5VDRfJJaNpOzuYOqJ0tM5k11xXYRcLv90XJqlA
 2MRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtCFXugkDnstWTTiKuRvzYzhHckL7JM7E3BHW1UK2iCaPvf7XlAw8jcrvnQbAV3Bgy8g+knvOojJdu+ED1I9Pr3JiIGlo=
X-Gm-Message-State: AOJu0YxzfjHE6p2+BcRxgEX2RML2zQqaWQm6QVpv2v3rgcmy8ADJoB0j
 IUcoyi2PkItRbWaGTyq79kosMu99fRKG8xCVsbK5b87h1MmxR2m83A2mvgjhF8gIu5cOjIm4kea
 x
X-Google-Smtp-Source: AGHT+IGi7Z+UanzUq5fwY8gqpsHzrd+QkdN1eKnnOwNeUb/+PfB33DPIiExmAweOYqtkzOmsoBnSKg==
X-Received: by 2002:adf:cb83:0:b0:34a:4b5b:a4a with SMTP id
 q3-20020adfcb83000000b0034a4b5b0a4amr8497772wrh.47.1713865483382; 
 Tue, 23 Apr 2024 02:44:43 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 l37-20020a05600c1d2500b004186f979543sm23576224wms.33.2024.04.23.02.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 02:44:43 -0700 (PDT)
Date: Tue, 23 Apr 2024 10:44:56 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 02/22] target/arm: Add confidential guest support
Message-ID: <20240423094456.GA4454@myrica>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
 <20240419155709.318866-4-jean-philippe@linaro.org>
 <ZiKa6MQaujEMlC23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiKa6MQaujEMlC23@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 19, 2024 at 05:25:12PM +0100, Daniel P. Berrangé wrote:
> On Fri, Apr 19, 2024 at 04:56:50PM +0100, Jean-Philippe Brucker wrote:
> > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > support the Arm Realm Management Extension (RME). It is instantiated by
> > passing on the command-line:
> > 
> >   -M virt,confidential-guest-support=<id>
> >   -object guest-rme,id=<id>[,options...]

Hm, the commit message is wrong, it should say "rme-guest".

> How about either "arm-rme" or merely 'rme' as the object name 

I don't feel strongly about the name, but picked this one to be consistent
with existing confidential-guest-support objects: sev-guest, pef-guest,
s390-pv-guest, and upcoming tdx-guest [1]

Thanks,
Jean

[1] https://lore.kernel.org/qemu-devel/20240229063726.610065-13-xiaoyao.li@intel.com/


