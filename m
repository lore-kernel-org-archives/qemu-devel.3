Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65504CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 19:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRbPv-0004IC-7y; Mon, 25 May 2026 15:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRbPt-0004Hz-VU
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRbPr-0003uN-0t
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779739005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/TZO+G0dZVY7MHwEpd1YawhiilgokZrFGlh69a/DAuU=;
 b=hXNk+rnu4iXtY/5DIjtijEwasn4dasX2llsHpm9eQHIZLyasbqB2IPRt2cedF8m6uck4Kq
 rjBq6A6VN3ZOH5eLh1wFChhkvpvCDXc1q38pj9Cvni/NvYUY0e6IweQLebjYLfz5Yry1KM
 Va85syGqUMlbdx4RHnWVDRpaI+14Fb0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-0D3pHTI8Po2RARfoIUMDZA-1; Mon, 25 May 2026 15:56:43 -0400
X-MC-Unique: 0D3pHTI8Po2RARfoIUMDZA-1
X-Mimecast-MFC-AGG-ID: 0D3pHTI8Po2RARfoIUMDZA_1779739002
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44d79da8cf7so7498689f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 12:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779739002; cv=none;
 d=google.com; s=arc-20240605;
 b=byp7BjQOlmGOKTy/ymqEZKQFQftz0QYINOjHo1T2mfTDiDo3vopjPTQ0VzNkBFWKfH
 gcAXS9XahgmuirpwntMf1Fsp/PWR0I4u4WFB2gaMet3Nj9cgdDn9gd+cWxytQK2SSg2P
 K0hGqIidDJdgNPzldR2zC0ynIfVZlKa9lciA2VNuIAVR69Z630zyjnvDoA+lhAzos/ZL
 ShVoA83/cbh6hF6mrKyaS5F8kAyA2nLMSEH4WMY4cWv77NQSNvCF+tWXwIcrnF3lQgRX
 CRTcI5n1ICc08Ei+7zsSANfwg8ouW4XCy3YrwP8Kj9o3FnpqhoVY7P3hbFxY3Az2IGrY
 ZcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/TZO+G0dZVY7MHwEpd1YawhiilgokZrFGlh69a/DAuU=;
 fh=QVKrYBsudDYNde24GGluNXHf+t1RNPmceo+N5mzrAqY=;
 b=bvNBSfmHMXTlBuiCgZ/dPmD2nTnwy1vrjuxSOy9SUrJOUniMgDK/V0C2A/E2G1436I
 axakuV1Iw/kPnWwwxDhEZ/m1oTjsQK+VYWghQbR020P4CLtp7DwDOUagltiQz88JS7ed
 rWFhr0UFcinoZWkMSXHuE35H/AN9my5H4rlzttLIZImwYWgUrkYp46LTRjPJUi22JesV
 aUdRm0jTPmNVO0VPseI3w/TuEQ8Wt0+CKWgFUlbnt7/Ony+W0IRasv7fV4IdqMNrEOXj
 xqRT4SWz+brdPO3ndOXdAlMB1rm9ocYljCDDU25v4RIfsXfdYgOW1jnky3HLoauPwgdz
 RAyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779739002; x=1780343802; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/TZO+G0dZVY7MHwEpd1YawhiilgokZrFGlh69a/DAuU=;
 b=qFlsO3iVWZ49QeBLorqcrIWE/QSW6EUuwnHxakK7kgEQAD+OVVFtTNZNzgK2QzpFD2
 eMBp+d5IprS0TSciDAvB7pqZDS9AyG66Kwrsy+WcN6YJGBA9Ia00AnzKTdQbqtcNXxHi
 gWu/Co2U8kJdQ2NPHLTG1sDBkQgk5THa+WOqf04KPUBT5/mLpmC2wO1VCUlorUkxFyyV
 Su6qT6ajLXSm8+NSG6hf+YtVdhH6siVU+SW24s99jS+1s+siMbIq1HiJ6ogx/Okw4nhg
 PBR3Sne+EXCWH9ye5uO4YvAASxR82IVvj8+wXGsaVwkS8q6/fzZdikOMcEsYmaVl25Oc
 ma5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779739002; x=1780343802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TZO+G0dZVY7MHwEpd1YawhiilgokZrFGlh69a/DAuU=;
 b=BKmsMtunGTzmlxBL4GWzZL/MFNYaGYGkg2UBOOW+CTPSb4sINfibjD2SmKbWbFwLTe
 QZ4mpYDNpmbXGpHgpNeM446n9XTNKkfKCLYno45aihP+dezH2Nt8JVZXwTZVsh2WjVFO
 a80HZOazwAgyJe4VxoVVbCc+bCjtd8KpWWzIx3885eoQyAli5dAky//Kwqf+8cTtOIp0
 D7wwWyIcMv5m2PLhqyhp4hpREVqINjUY0Bp3Nm1EHCdZrSbuoG+mYwWWxhbLi4v1ZKWv
 Sog3LFV/OkQRKcXECPCIAAM21iT5FcH9Mea2t1AB0owjyuRe2G40BFW7vM9YguvrnMrz
 qyFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NUHUPyXBkaeGO5Ur3OisY1DMtSdDJv1WYQhxSt6Hg5voGs0KIm0FWGMrcE+/Lt69c7HEK99Me8ol5@nongnu.org
X-Gm-Message-State: AOJu0YykHXInyadb8ziGO8ubxmcViGBEe3juG9waSuDh5pwu6yFUoWYr
 pHXZkfwekSxn+2O3vkaYCOwsa+6kL2dmuI7BSp49q4S5TldO8/535QqVcz6pOcG7m7NjhUcZg0W
 jbMZggq99QdUMGEDohTlf9okwo6xps0TEWbFw6+o782+Y0iE8z791OXDGnofGMnPnYWDff0O0w0
 gPkuZgd8rL77Ql4iVCjzSGvAHAdU1PgWU=
X-Gm-Gg: Acq92OFwZL1XJKmWNGtKxrFSY65lYigiibejq0GYsLAPZjKzzS4PlN6lIJIMaXz/zut
 zBOVAY8B/bgEzjvcl+gG1ggrxvILNDHY8R39T3IJFO/vP0a7xVq0hJzHH+tVMrb8FmeqO8aS3gE
 S2STj+aA0f7+GKAW5ylFw2NolwJb/7YWWY/hhgqQWy2SqJOKQUEuXjkEBAE6bK0+DrqhIxPigSo
 KrDY55KeHgNTW6byMUTgqewPAGPLDQuvkmQvX2PhOMjg98N9L6QJ0+SOHa4BxA7UwqiMo/1oP9K
 gs8=
X-Received: by 2002:a05:6000:480e:b0:45e:739b:3e3c with SMTP id
 ffacd0b85a97d-45eb36418d3mr23835598f8f.0.1779739002216; 
 Mon, 25 May 2026 12:56:42 -0700 (PDT)
X-Received: by 2002:a05:6000:480e:b0:45e:739b:3e3c with SMTP id
 ffacd0b85a97d-45eb36418d3mr23835577f8f.0.1779739001869; Mon, 25 May 2026
 12:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
In-Reply-To: <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 May 2026 21:56:30 +0200
X-Gm-Features: AVHnY4KAfsTdyMSPXzzRov7X-RJ8sy0lkeDNGHHUQywyrCOSSwH_-M0YOJZSecU
Message-ID: <CABgObfYJiTZm+SOG+vF06sSfa7PGCuhrpagqwbmssjjFuOiUrQ@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Warner Losh <imp@bsdimp.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ffef430652a9c650"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000ffef430652a9c650
Content-Type: text/plain; charset="UTF-8"

Il lun 25 mag 2026, 19:15 Warner Losh <imp@bsdimp.com> ha scritto:

> The code produced by AI agents has no copyright.
>

This is not entirely true. As models improve their capability to generate,
they also improve their ability to recall exactly. Stefan gave more
information.

The ability to search and reuse code found on the internet could also be a
problem. In that case the code is not produced by AI.

While this is *generally speaking* not an issue, it can be in specific
cases.
https://www.devclass.com/ai-ml/2025/11/27/ocaml-maintainers-reject-massive-ai-generated-pull-request/1728083
is only about six months old.

Also, I've softened this paragraph
> several times, and it still comes across as more confrontational than I
> intend.
>

No problem at all!

AI's primary issue is verification. The folks being flooded can't verify
> the good from the bad in the flood and tend to have a knee jerk reaction to
> protect themselves: ban it.
>

Being cautious and open minded at the same time is a good way to react, IMO.

Unstated issue: How do we help people that want to contribute grow their
> skills using AI so they make submissions whose quality if good enough to
> be worth our time to verify and review. It's an industry wide problem,
> along
> with how do junior engineers become senior in a world of AI doing the grunt
> work they used to learn from.
>

This is not our problem to solve. What we can do is participate to outreach
activities for students, such as Google Summer of Code.

Paolo

>

--000000000000ffef430652a9c650
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote gmail_quote_container" =
dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 25 mag 2026, 19:1=
5 Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt; =
ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div dir=3D"ltr">The code produced by AI agents has no copyrig=
ht.</div></div></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">This is not entirely true. As models improve their capability to gener=
ate, they also improve their ability to recall exactly. Stefan gave more in=
formation.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The ability t=
o search and reuse code found on the internet could also be a problem. In t=
hat case the code is not produced by AI.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">While this is *generally speaking* not an issue, it can be=
 in specific cases.=C2=A0<a href=3D"https://www.devclass.com/ai-ml/2025/11/=
27/ocaml-maintainers-reject-massive-ai-generated-pull-request/1728083">http=
s://www.devclass.com/ai-ml/2025/11/27/ocaml-maintainers-reject-massive-ai-g=
enerated-pull-request/1728083</a> is only about six months old.</div><div d=
ir=3D"auto"><br></div><div class=3D"gmail_quote gmail_quote_container" dir=
=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr=
"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Also, I&=
#39;ve softened this paragraph</div><div>several times, and it still comes =
across as more confrontational than I intend.</div></div></div></blockquote=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">No problem at all!</di=
v><div dir=3D"auto"><br></div><div class=3D"gmail_quote gmail_quote_contain=
er" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_quote"><div>AI&#39;s primary issue is verifica=
tion. The folks being flooded can&#39;t verify the good from the bad in the=
 flood and tend to have a knee jerk reaction to protect themselves: ban it.=
</div></div></div></blockquote></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Being cautious and open minded at the same time is a good way to =
react, IMO.</div><div dir=3D"auto"><br></div><div class=3D"gmail_quote gmai=
l_quote_container" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>Unstated issue: How=
 do we help people that want to contribute grow their</div><div>skills usin=
g AI so they make submissions whose quality if good enough to</div><div>be =
worth our time to verify and review. It&#39;s an industry wide problem, alo=
ng</div><div>with how do junior engineers become senior in a world of AI do=
ing the grunt</div><div>work they used to learn from.</div></div></div></bl=
ockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">This is not ou=
r problem to solve. What we can do is participate to outreach activities fo=
r students, such as Google Summer of Code.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo</div><div class=3D"gmail_quote gmail_quote_contain=
er" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div>

--000000000000ffef430652a9c650--


