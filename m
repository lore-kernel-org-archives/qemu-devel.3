Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2F7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhaAO-0001mn-Jq; Tue, 05 Mar 2024 14:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhaAN-0001me-8A
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhaAI-0002CW-AU
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709665765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8vYdse8NbojB3Nud/OllehdhrkH1XAu5HQMFbB9PSe8=;
 b=BEPg++pN3xZQZVVS6yzHY2W69xDDTMRelzk427BgpFkqUdBy6uxCEuO4Jxx002arCxignH
 cTrN2Fxx0bWSBXoW4tIKeFKzxtJ+aWF+JX9RZSYACCJNXYMjcNa2agZb2Euefep0m/SdcE
 I4mveO9JsWq8ECWASouQo4+DmvB+Ej4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-TpOg0MvbO_qLsCXIxL4uOA-1; Tue, 05 Mar 2024 14:09:20 -0500
X-MC-Unique: TpOg0MvbO_qLsCXIxL4uOA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d34ef51653so34330851fa.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 11:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709665744; x=1710270544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vYdse8NbojB3Nud/OllehdhrkH1XAu5HQMFbB9PSe8=;
 b=uG8J9K87bccfNfHvUm68hnqZWDAvdYqlMImn6S+s6ZrIgA1SzOn91gOD2M4u6pp7jM
 VlGkrHITxnGbANnHufTLLEtyC4bE7eBls2pJY8HNAwr2JN0OrOOBK10VFD7APRb5zXm/
 W/MGVFd8fq+MQAGRg9ZkpOet+T2cT0cV7exahb2tXhKCYbEehkLhE4JW2de04OjaGPnw
 9F7RnuY17rZ70y0ViPiBvG7tIemuYeFH4lHl0s/YymhQdOz9BobUnvAINAd86X7zv6/B
 71eGme9OQwu34UQe7ozyDMG7z0IqRNpQarbF+SC2tEtD0p6cEpHwtbYI8o+WTNxoXgEi
 0/dw==
X-Gm-Message-State: AOJu0YwXRxwYIlfkexZIZcsuvBszhLNwO+XVMX/IVb/ZlPzopvaPUMU8
 tsqx+Tpuo54NGt06WSNfNmEzTbApaL8i3kk+YjcWO/c7R+Q0cyB3cRCWrTq9zMFKIupqcXmIV+t
 DK4AZjlK4PQ13SGUMRK5HukpR/npTw85lwxuJtp8k4NTdpIvy5TPK5N+yx3ariMy8fPfrZB4d+r
 LF69RSvPxa2IiYqcjPLQbC7ya5cHHTWRnXvduO
X-Received: by 2002:a05:651c:a0a:b0:2d2:a2f5:596e with SMTP id
 k10-20020a05651c0a0a00b002d2a2f5596emr2448516ljq.38.1709665743769; 
 Tue, 05 Mar 2024 11:09:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKHBXOrjVnyhZ0frcgul7YrdUPCLCE3nYYsGXiA/JMBMXxbi7BhhrF62tzMtGjEScYDRClGQ==
X-Received: by 2002:a05:651c:a0a:b0:2d2:a2f5:596e with SMTP id
 k10-20020a05651c0a0a00b002d2a2f5596emr2448498ljq.38.1709665743284; 
 Tue, 05 Mar 2024 11:09:03 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 ds13-20020a0564021ccd00b00564da28dfe2sm6129582edb.19.2024.03.05.11.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 11:09:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	berrange@redhat.com
Subject: [PATCH 0/2] ci: allow running Coverity Scan uploads via GitLab
Date: Tue,  5 Mar 2024 20:09:00 +0100
Message-ID: <20240305190902.364753-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The machine that is used to upload QEMU builds to Coverity is used daily
as a development machine by Emanuele and myself, and as a result sometimes
its podman/docker setup gets messed up.  When this happens, Coverity
uploads might stop for extended periods of time.

In the interest of tightening this and of depending less on infrastructure
maintained by specific people, replace the manually-managed crontab
entry with a new job in GitLab's CI; this is also what Libvirt does.
The rules to trigger it are a bit different compared to other jobs:

* on mainline, it only runs as part of scheduled pipeline runs.  Rules
  are added to remove all other jobs when running from a scheduled pipeline.

* on forks, it is always manual (and only appears if QEMU_CI=1 or 2,
  like other build jobs)

For now I implemented these rules directly in the buildtest.yml file,
but it is also possible to add a QEMU_JOB_SCHEDULE variable.

Example of a working run: https://gitlab.com/qemu-project/qemu/-/jobs/6324308338

Example of a run that is over quota: https://gitlab.com/qemu-project/qemu/-/jobs/6320681674

Paolo

Paolo Bonzini (2):
  run-coverity-scan: add --check-upload-only option
  gitlab-ci: add manual job to run Coverity

 .gitlab-ci.d/base.yml                   |  4 ++
 .gitlab-ci.d/buildtest.yml              | 38 ++++++++++++++++++
 .gitlab-ci.d/opensbi.yml                |  4 ++
 scripts/coverity-scan/run-coverity-scan | 51 ++++++++++++++++++-------
 4 files changed, 84 insertions(+), 13 deletions(-)

-- 
2.43.2


