Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BF606A697
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ju3h+sEC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qr9Ia9lv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxhv-000294-90; Tue, 24 Nov 2026 16:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVxhu-00028F-5z
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:05:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVxhs-0003bZ-GU
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795554338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bu4NPkAfAAYUOpQXq+vjW8BMXDWwRj6cprg5oTgIVGI=;
 b=Ju3h+sECMRLauuglYF1DYN6QQcH0ld6i+mr4lSwvcMtd+SyQFOn39SQSfQ8COWC3JWIIvM
 dnSLfMWsOARrobobe23i/4Efn9lfOw6pV/9dvPXANGO2+ZTpxEDUz4lUOm2qwVqwPonpFe
 bXvd8tQY9jy6mM50azq8ZlGicuvAiHI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-qJayNLbbMLSGYU9lONCXAw-1; Tue, 24 Nov 2026 21:05:35 +0000
X-MC-Unique: qJayNLbbMLSGYU9lONCXAw-1
X-Mimecast-MFC-AGG-ID: qJayNLbbMLSGYU9lONCXAw_1795554335
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94975041698so1306466485a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 13:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795554335; x=1796159135; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bu4NPkAfAAYUOpQXq+vjW8BMXDWwRj6cprg5oTgIVGI=;
 b=Qr9Ia9lvJsKdAZ6FI2/wMjzcQhwJFhq1v6nY3cvj0MdGjFq7wPAVuRp1MjigxP8ywE
 4FwRgBv8qrThmNUy1oZubciDDPVJo8bxIIk9xpNzm64UTHmh/9xGcS+Tno1ZrXK7CPZb
 BMl7bhTcD9RBqueKGUe6IcgL0i/EXbyGWC+93p0FUJ3ypom8e9svS3KUuNsrrTfA9ryu
 AR2easWNUyH6hcenZ2uU8oYUENtWRKdLinH0SVQt6tS2enCLMrjpZ7z7x+fOM9uYKY9S
 x0lRp+ZGCOQLleHh5K0mQayyfgXfjb2/SnJBspzg+KziUdd/3aNvaon64ylsBo8Vb3V1
 fhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795554335; x=1796159135;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bu4NPkAfAAYUOpQXq+vjW8BMXDWwRj6cprg5oTgIVGI=;
 b=2ql9jULV3kmZ3w3tmdjpX+J0y/GwVFt7d1ovPvmPBQojfbvFkJzy6cwWJsxjNNmL9f
 6LFHAmOc1UiMbjbyaUNkYDXODuJeNAhx6D9kWys0bzaYj6+dzS0llyqbrgBCWEMRIVOi
 2Fe/KL0sdXURHAEBlO129rUlv3DA4kI/ZKWUzJjj2CfPyjJcx1YlMIyVM0axwB3Ql5nv
 skeiASfUAB3Oo042WRHnBHIybsQ70q95Ml5Mwhsg6yCsS1aK7V6o8R3C8sAPBW92OGAY
 hqNsulVS5tTnCpK5XbiJGOzuSCBfT1iZEUcTKOaVgQ1anozTcPutDX9X5ws9C1+3AZnq
 i3Dw==
X-Gm-Message-State: APuU4Z+gKnOEzbjjSKQfoiY9YU/0IiHVLmzvpSZRDgwvjr3GPS3f6KEC
 ObvFBUj/apOjDN6+vfFVfgjeo2dxd8tJ72mTj43g0Lf67c/Nn/tjjM6gvXqzdCw2JGLCQlZxpep
 AsqodzE/yOv2aPGSydlbhJGLiyp8eGsYqwGMZf94QCfyKKZG5gaYqOfXV
X-Gm-Gg: AZFdTZeyatJjQPBfB7xmVY1L+w9oFEQO6xJDFvAmVmfHJxDWjxHihtjGCBvd+QM1J6Q
 TTAqVQovUkY5hluYYHtNSe/B8MpwaYr835EDetiSWiTGASp7aylew8DnN9QYVVhj3/KAAt/Yy+s
 ENbG0VbHDnkvFbyARAw6ScBbjvNa7UY5pLUCoFIZxS29liyo8X92T3zPI1sOS4yKzTz5ChC1tEA
 hDCXEueKC2XqSVaL199Z0Bz68ymwX0LCFjhERccUVqkh8GJPrTKe/e5PYZxu6DcEMzJyJxFh/cE
 McIYbR5A2elcljuuHvpL0V4xq+0m5vwoADT9uoVUZS9OsFW5HbEoQQt8Fla6jlL4MUJTI7TKmyN
 GOcD20YJnDW/EBzz68+nM7CcEAX27JooelELQ+yS5UufZ
X-Received: by 2002:a05:620a:1b87:b0:949:7015:7968 with SMTP id
 af79cd13be357-949ba9a57f8mr2591854385a.18.1795554334923; 
 Tue, 24 Nov 2026 13:05:34 -0800 (PST)
X-Received: by 2002:a05:620a:1b87:b0:949:7015:7968 with SMTP id
 af79cd13be357-949ba9a57f8mr2591847185a.18.1795554334304; 
 Tue, 24 Nov 2026 13:05:34 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94a0189dbcesm91601885a.13.2026.11.24.13.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 13:05:33 -0800 (PST)
Date: Tue, 24 Nov 2026 16:05:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com,
 peter.maydell@linaro.org, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
Message-ID: <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-2-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124164217.1768040-2-pbonzini@redhat.com>
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

On Tue, Nov 24, 2026 at 05:42:15PM +0100, Paolo Bonzini wrote:
> +The QEMU community is a collaboration between humans, not AI agent
> +façades. The following items MUST be written by humans:
> +
> +- cover letters and commit messages
> +
> +- responses to reviewer comments
> +
> +- issue descriptions or comments

[Just a pure comment, so not a request to change anything at v6 to block the
 pull at all]

I think this is the part I raised the pure question in the upstream call
today, on that we won't really be able to identify what is written by AI,
and what is written by human.

If we can't identify that in a realiable way, IMHO the policy here will be
hard to carry out.

It is also not nice to happen false positives that we assumed something AI
generated but in reality written by the author, so we may always want to at
least ask politely, or think twice before assuming the series contains AI
generated contents of above just for courtesy.  It's just that the more we
do so, the less helpful this rule is..

The other thing is I need to confess new models can generate good commit
messages, cover letters, etc.  at least when I tried, and at least
sometimes.  I need to confess AI is also the best English teacher at least
for me..

I had this feeling that this rule will only add (some light) burden to
whoever fully respect QEMU's policy, and even if AI could have generated
something very usable as a base draft (obviously, above didn't even allow
human updating the AI generated contents).  Then for many who have
generated good AI commit messages and didn't notice this rule, we likely
will just let those pass too assuming it's "human words".

OTOH, to me it'll be very helpful if we could provide what we want exactly
in cover letters and commit logs into AGENTS.md.  It can be either pure
formats, styles of expressions, best practices of comments, etc.  But
actually I'm not sure either, because IIUC very new models are getting rid
of skills people wrote and can do sometimes even better with shorter prompt
than complex + long prompts, so maybe we really only want to add the most
important prompts when we really want to do so.

Thanks,

-- 
Peter Xu

