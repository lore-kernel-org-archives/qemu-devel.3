Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F964C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 03:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0uvo-0005YR-2O; Sat, 27 Apr 2024 23:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1s0uvk-0005X4-AK
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 23:10:20 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1s0uvi-0007T1-Ff
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 23:10:19 -0400
Received: by mail-yb1-f179.google.com with SMTP id
 3f1490d57ef6-de56d4bb72bso3965202276.2
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 20:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714273816; x=1714878616;
 h=content-disposition:mime-version:user-agent:mail-followup-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaFYlMIcXuck1SBV9otkdNe1ye8VuVew4B6r9SnMah4=;
 b=dPptQyl4tslQ+/+WFWyXQX+0kNcsl3bqNlXR3gdi3BIgYB0Mk3nTNwkoK14bbYJIkU
 PpntAIyVJVt94azd+TSimwadgT6fuOitNV/ZxVkIuYfhJtpD+IQWD2utO+zEOQ6MNhpa
 0veJ0G2BFLhnxAJCj4fNYMDZlfEIIBhxI57eGW1tN1ijeKeK0H7ufEuvqsjgRCD+ksK2
 9+RsK6Qm+EXWXSOLHB4OlMBEFHDZ8Fhy8ugTlgvXW84CY+cKk4vsG71iw9u2wemgVNzD
 s1R82MRWltxa2qx0gOhelC5QtHh4ssxbHvCu4D1r8xzLt+tUCHlW7ViZmP5ADCI0X4Ai
 CqDA==
X-Gm-Message-State: AOJu0YxujHnRdIWvoF3iOER2au5MWYgDkYxHunmrXTDC/PRJ+aB+HxXe
 0FnPnGF8Az+ZaAVfaxM1zOUVFtPgsJvQsPzBs2EsCoIwA66COkXPUlEPSWIb
X-Google-Smtp-Source: AGHT+IH+nIZ1sb1uRIpCiUtTaAGcCTyA3jmOh6qLr+FEYXmECTt5MBpRoZ7dohXD12wnZMrDCIXmMg==
X-Received: by 2002:a25:c74e:0:b0:dcb:ad22:1b1 with SMTP id
 w75-20020a25c74e000000b00dcbad2201b1mr7553658ybe.3.1714273816222; 
 Sat, 27 Apr 2024 20:10:16 -0700 (PDT)
Received: from gmail.com ([2601:196:8501:5850:fbe5:3f64:88a7:2a1])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a05620a148e00b0078d6b42ca02sm9352423qkj.120.2024.04.27.20.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 20:10:15 -0700 (PDT)
Date: Sat, 27 Apr 2024 23:10:15 -0400
From: M Bazz <bazz@bazz1.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: Re: [PULL 0/1] target/sparc late fix
Message-ID: <20240428031015.3g3nt763hehm2o34@gmail.com>
Mail-Followup-To: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
User-Agent: BazzyWazzy/13.37 (TempleOS/x86_64)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Received-SPF: pass client-ip=209.85.219.179; envelope-from=bazz1tv2@gmail.com;
 helo=mail-yb1-f179.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

>Applied, thanks.
>
>Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
>for any user-visible changes.

The 9.0 Changelog was never updated. Could someone with the permissions
please add the following to the SPARC section:

sparc32: Fixed a longstanding softmmu bug that caused kernel panics
when the UserTxt ASI was accessed. 

Appreciated,
-- Bazz
>
>-- PMM


