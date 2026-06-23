Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11625CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5Of-0007mX-Cr; Tue, 23 Jun 2026 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wc5Oc-0007hm-Uu
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:58:51 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wc5Ob-0003U2-6j
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=QK86wxq1N/HMd5uhtpw2nMsv9Fo+IEfS+x0dp5sJQa8=; b=ew3/l2sImnr5PPBr
 QE3Z2tGiDhPAnB2RZ2qPcTUP/9xcqB5VMcrpBoEHSoTTQ7OQUkpBo2oQi/MUfYhlacT+84oJ/Cfec
 q9YVcWO2atfHHkWgnR6GAX5rXglX1vx8xBVoxiYQWEeHvsYEfwQSsmHQAwPqzUnkNSazSNYK0sOXX
 45Pul2EhkJa/TTF5XLL2WjdKuH98v/z7x9elrNmNQXyF9aheX/YljRQFPACHdcLAMl4PwPCcktQQB
 6nSsFesIBlXmuodfE3Kin+3zRu8W0QoYOD87iR2ZifoKsmwRCAmcMf+tkaq7IeX6BsHkzMOrCD/+d
 mVWTo3vPWUUqg9fwaQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wc5OV-00000009WpL-1MOQ;
 Tue, 23 Jun 2026 17:58:43 +0000
Date: Tue, 23 Jun 2026 17:58:43 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 34/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
Message-ID: <ajrJU5TH4yOh0vnq@gallifrey>
References: <20260623095551.2106712-1-berrange@redhat.com>
 <20260623095551.2106712-35-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623095551.2106712-35-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 17:55:47 up 38 days, 21:08,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
> options, updating `-mon` to state that it is legacy syntax sugar
> for the new `-object` args.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qemu-options.hx | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c799286153..98c74cc9ff 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx

<snip>

> @@ -5730,6 +5740,46 @@ SRST
>      they are specified. Note that the 'id' property must be set. These
>      objects are placed in the '/objects' path.
>  
> +    ``-object monitor-hmp,id=id,chardev=chardev_id,readline=on|off``
> +        Set up a monitor running the Human Monitor Protocol,
> +        connected to the chardev ``chardev_id``.
> +
> +        The ``id`` parameter is a unique ID that can be used
> +        to dynamically delete the monitor at runtime. Note
> +        that monitors created using the historical syntax
> +        will be allocated IDs following the pattern ``hmpcompatNN``.
> +        Mixing ``-object`` with the historical monitor syntax is
> +        discouraged.
> +
> +        The ``readline`` parameter, which defaults to ``on``,
> +        controls whether the monitor provides interactive
> +        prompts

Missing full stop.
So are you allowing a mode that I don't think was previously possible;
HMP syntax but without readline?
'interactive prompts' seems a strange way of putting it - 'line editing'
is more normal isn't it?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

