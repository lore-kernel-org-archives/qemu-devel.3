Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4B8C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmk3-0004Vi-QA; Tue, 13 Aug 2024 04:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sdmk1-0004UV-5x
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:18:53 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sdmjz-0004U0-5y
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:18:52 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52ef95ec938so5366403e87.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723537129; x=1724141929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wekwWcKPpcbICUCz2DBJbVkCkdlaEU0VzVRtIIh0nGw=;
 b=KIYlGPuImKRmpd/Gf8bVX9YnokyowAR9cYdA3GwELLCqPkXRi/hLJMD5kc3rvmSf6c
 fbsHN5N59jg/l3kVtnGqCffkLhE1/w1q9qdaJpVkUNlKuf0VPNhmdlDwZAJeE3n2BDUd
 0CMZqtJ0U3nGxlBZp3t/V0N22ayznpfb8Y4cM+P/5aZfJSxJODHtYAlNtjVP3LUeHHRu
 +KthCFeCV392HjNQiPWY080HfZDRnByecBwVr4duJq7V53XxxF5SuAmL5S5+Q3tSIeO4
 F+7phOSMq2FWfzHe93wGPrev900YgpSVxYlVJ8F82JFXSGeA+LlOWNRbIWdCQh2Szb4y
 uKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723537129; x=1724141929;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wekwWcKPpcbICUCz2DBJbVkCkdlaEU0VzVRtIIh0nGw=;
 b=O0+rfNuvUdofjL0sswTn78UeL738mG08QopKkXkHMG9st/OteJXsNcjsMiUWFsrTSu
 lqSU3eCNK/T+z/Nk2IqEkJjEtDhKT0RYYBGT4ll79vKemTBjOrWYbfSRm7+hrNHGuwO1
 nZcJyB2pQP2oNpEEZEhjrskYBaPl5TBNGPp5+fL66FU0yQT/DUYe5h3jP6n3diXxzc31
 O+HxwaRz+gQ7kFv26nBo2R92SOT2Xea9Q1om/uwLoaFSedo8vLJxskYBMNIFf4azpoSn
 g2sCncyEv1oHqRrfOs33Sqz1PYK1k0165KDtW6tdDYPr28Pky35kGCn7r4QINPjRrDXd
 9TJQ==
X-Gm-Message-State: AOJu0Yz9frgOYYuf+6F55XJlqJyRcTIrFQVWFK92Ns0MU0DjBXDhhx5+
 DHF92vOhRfqKoRL1QM0lhuvSV/gDnUvgtiVrN+gYSdSViScHDAzd
X-Google-Smtp-Source: AGHT+IEcwtyRFLWGJuPu38jgeu1iip4Tq+cgv3F6CcjRidNmJOUbim1N9BMbd6H5CSZaLyDoUE1raQ==
X-Received: by 2002:a05:6512:3049:b0:52c:952a:67da with SMTP id
 2adb3069b0e04-532136a4728mr1976460e87.55.1723537128193; 
 Tue, 13 Aug 2024 01:18:48 -0700 (PDT)
Received: from [192.168.14.190] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c7965aasm217597995e9.38.2024.08.13.01.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 01:18:47 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3a9f0e9a-3873-4cd0-8773-c2ed6230da81@xen.org>
Date: Tue, 13 Aug 2024 09:18:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qdev-monitor: avoid QemuOpts in QMP device_add
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20240801140552.1021693-1-stefanha@redhat.com>
 <87wmkz5oqk.fsf@pond.sub.org> <20240812181534.GC69160@fedora.redhat.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240812181534.GC69160@fedora.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=xadimgnik@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/08/2024 19:15, Stefan Hajnoczi wrote:
> On Fri, Aug 02, 2024 at 10:10:43AM +0200, Markus Armbruster wrote:
>> Can we additionally cut out the QemuOpts middleman in
>> usbback_portid_add()?
>>
>>      qdict = qdict_new();
>>      qdict_put_str(qdict, "driver", "usb-host");
>>      tmp = g_strdup_printf("%s.0", usbif->xendev.qdev.id);
>>      qdict_put_str(qdict, "bus", tmp);
>>      g_free(tmp);
>>      tmp = g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
>>      qdict_put_str(qdict, "id", tmp);
>>      g_free(tmp);
>>      qdict_put_int(qdict, "port", port);
>>      qdict_put_int(qdict, "hostbus", atoi(busid));
>>      qdict_put_str(qdict, "hostport", portname);
>>      opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
>>                                  &error_abort);
>>      usbif->ports[port - 1].dev = USB_DEVICE(qdev_device_add(opts, &local_err));
>>
>> Trying this is up to you!
> 
> Paul or Anthony: Do you know how to run usbback_portid_add() for
> testing? I would like to make sure that suggested the code change works
> and don't have experience running the Xen code in QEMU.

Sorry, PV USB is not something I'm familiar with. 
https://wiki.xenproject.org/wiki/Xen_USB_Passthrough suggests that `xl 
usbdev-attach` might be the way to test... but you'd need a system with 
Xen installed and suitably configured guest, so not trivial to set up.



