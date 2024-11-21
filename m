Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CA9E64006
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECRM-00044h-Pr; Thu, 21 Nov 2024 14:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tECRD-0003y3-Ma
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tECRB-0006YL-0g
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732215715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+zzY6TnuRDKolmTw3u4P7UCZ/d0RIcOlcorVAx6u3kQ=;
 b=gbEx9BHQ7vXKdxvohQXwSeebf8RAZMr3iNnriOnv2ltUQ2y3mTzCqJP7csgSGk8Qj4OKwS
 TMomJEGEdO341EvhGEDAHhRlq+D3nONiSuUa38EMVGWvYfZm6vAY0XBeQIMuxzVhFfj+fw
 WwR2CHIXAZes19ahtXjBdIE5sHRei5E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-DqC8RoRhNpaeZiB25EhQBQ-1; Thu, 21 Nov 2024 14:01:51 -0500
X-MC-Unique: DqC8RoRhNpaeZiB25EhQBQ-1
X-Mimecast-MFC-AGG-ID: DqC8RoRhNpaeZiB25EhQBQ
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2fb4c35f728so11280461fa.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732215710; x=1732820510;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zzY6TnuRDKolmTw3u4P7UCZ/d0RIcOlcorVAx6u3kQ=;
 b=fPI+SvB0mr0cBVE4ttiec+0jY7+kykXdzz7ByFhhGz0yI+QQBGR5QxW/gjZjkjoZ1g
 UrMqkMVmATTHIvcxUF41Lgaw6bYFCAtUJErBlBB8sHi+XfmJeMVC1hNZ6N7ojcjQtB+m
 n0ELFLBavOn5eu7DADf8PxXzoeRi9miap+vKIZ5obyE6zMwUKmIRid3ZW9lTmQwSVYb1
 oi4NMgq0jYCVDuF9k97TBIHRwB3rAHB5y4S2qGii87CDLAYkyY1et0++TjVlFx31/YN3
 kdNnAZAlY0ZyNYkozF+CtzwAvKKGpScZmg8/8df7tiLbp2tOMSQURF3FESpkgfXsFCV2
 6rSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJxCKmg24ctmtKHb30dPME6ZfOt/s4Kqc+BDppV/9oy/gU9zl/g/wnyBOc9Y8BQtCHs4ucAAtRvtMk@nongnu.org
X-Gm-Message-State: AOJu0YyuD8XL/IAsQ/+ZjJXwum9hMOqsr8GZY+x0QQlSAUBod6AJFhTt
 frkTI+QXhtrm+JPRA+Pabw18+MsxOg+xKQN23SDemu8X3//MwG6DD/xDU3SetDGhlNXXjkZ+3Pl
 0HYTE3EA9F7QIef1Xi3vLOvN+jHo6WEqBWB1xj6DEeM2UEbz85RDR
X-Gm-Gg: ASbGncsLCiY13M9HZiJepZzXHsZ4cMzkPjrsWJgx1VtVwVHNGR8fNm6tXETE3/fHiia
 s5qg75hDKkixWWGNVPprda7nY4Abeq/ktMUnvVoC4Lhkvry8E4mtlMszgmDVvEv/ZKTyQCARW8C
 v1gYr3IEwn5fJl92ASImndmHYZw8B24Zm9T7/45niU1CfGlyGnr9htedLFijUgzKv4rLDbrG4SU
 Ehut5WBNSxuXPPFPHmg9fY+NLcw4Zyyo22AONSRVqQl9Kg6nD8EJEu5Z9WQbjgBJqcWIrbvTFgl
 OBc=
X-Received: by 2002:a05:651c:509:b0:2fb:3960:9667 with SMTP id
 38308e7fff4ca-2ff8db3068fmr77114511fa.14.1732215709624; 
 Thu, 21 Nov 2024 11:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMPA6LDaLZSAp26ic1kWPQAJJIXL5CzE6W1QfA9CmsDEAWx+zb4dLaQQPC8RzyLyRUzy7VFQ==
X-Received: by 2002:a05:651c:509:b0:2fb:3960:9667 with SMTP id
 38308e7fff4ca-2ff8db3068fmr77113931fa.14.1732215709047; 
 Thu, 21 Nov 2024 11:01:49 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28dd8fsm4466566b.39.2024.11.21.11.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 11:01:48 -0800 (PST)
Message-ID: <6986a8a8-e20f-46d6-935a-724f8480d785@redhat.com>
Date: Thu, 21 Nov 2024 20:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] tests/functional: enable debug logging for
 QEMUMachine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241121154218.1423005-1-berrange@redhat.com>
 <20241121154218.1423005-12-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241121154218.1423005-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

On 21/11/2024 16.42, Daniel P. Berrangé wrote:
> Set the 'qemu.machine' logger to 'DEBUG' level, to ensure we see log
> messages related to the QEMUMachine class. Most importantly this
> ensures we capture the full QEMU command line args for instances we
> spawn.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index f9c9de1166..e2a329c3e5 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -57,9 +57,15 @@ def setUp(self, bin_prefix):
>           self._log_fh.setFormatter(fileFormatter)
>           self.log.addHandler(self._log_fh)
>   
> +        # Capture QEMUMachine logging
> +        self.machinelog = logging.getLogger('qemu.machine')
> +        self.machinelog.setLevel(logging.DEBUG)
> +        self.machinelog.addHandler(self._log_fh)
> +
>       def tearDown(self):
>           if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
>               shutil.rmtree(self.workdir)
> +        self.machinelog.removeHandler(self._log_fh)
>           self.log.removeHandler(self._log_fh)
>   
>       def main():

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>


