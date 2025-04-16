Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF84AC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u53hG-0001H8-8J; Wed, 16 Apr 2025 10:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u53gp-0001Fk-Px
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u53gn-0004tO-Q0
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744813470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q8CbI7YFNj21yDqmjb88k0lLSJFd82KWDmHzO/GZVF4=;
 b=ZuSGQpw0jdbpUoX3ygnM+NsX8TySXj1tvxnM+fGtqLtNXHlg+EmfbCuQu7YhNbT0klgs5J
 6oulVw6jkNwM4sNYI8dwYW6yhfE8DknuEa9regvhhr2iAknzh0werk75837NcZAJATUJEw
 K4oWS9NU8BdShGt8DzJpfs4SGVqRKpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Ih15sPIdOZ28vap5B8rCyA-1; Wed, 16 Apr 2025 10:24:21 -0400
X-MC-Unique: Ih15sPIdOZ28vap5B8rCyA-1
X-Mimecast-MFC-AGG-ID: Ih15sPIdOZ28vap5B8rCyA_1744813460
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cec217977so40841775e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744813460; x=1745418260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q8CbI7YFNj21yDqmjb88k0lLSJFd82KWDmHzO/GZVF4=;
 b=KNHA+wQRdB88nwdJL0UBLIURu/s4vqICd913fSWFHYyE1iSug8dwuzfh46z3Ni9kZA
 WXeCXXjkpmHYA7JE5LD2XS22XhoqVzivkIZ3cdj0q4Es/MwzcOQxgDDrWu8OepYb/p49
 3B65twHMOdSs9wDcJCnWh0Tqpl78hIt3bFKS3qottuazvjJdixN4mfCHtSdU6NH2e+qS
 hRoWxaEWKIrrKxTlPqJ9es6UL1A7NlQwT5G/FeRqXdjAq3msiLdyw+OmdIP7QSJlcRMe
 IOX5he4AbfYXG7tsKDcJkjELHYOQC7gfX1y7+a11h9XLn3CvGjjxQFGsIYvGoxXfaLW2
 RyPA==
X-Gm-Message-State: AOJu0YzuFFhUvf+gvLC4ohPtmKmRJ9d0LDaWGfesBKECsiCNAQCOAmwg
 hpTlacg77fFwVglkGg71VNTHUa7axEfbSHEG9P9QW3A9Iy8dDq6qj9dP2dMt//OG+vWRYvIcClZ
 92SIq15gWTMYM95wsgvHVmUaFO0qGqdpvW3sJxsBNjtaKCqsAq0UjXrIMczDqR/AD4aQu4iLNU5
 m0OGqgCiVAn6kpfx3h56WZ7v7mM0k=
X-Gm-Gg: ASbGncvmF9uC5gaqfHcyZh1MGib49NGT+NabdWe7wX6VCE9u3ZnWec2rW64Qeob2uzu
 hH0A1p8hq8vQuJ3jjk8bk4nmI/GYCfWhgQzEeABl9/bjxabjvQZ9oVruQ7BZDSTe8xLsOEw==
X-Received: by 2002:a05:600c:54c5:b0:43d:10c:2f60 with SMTP id
 5b1f17b1804b1-4405e4b88b4mr16181365e9.24.1744813460206; 
 Wed, 16 Apr 2025 07:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPsD4cWB8KvnFFOp1rscTdMjNWmz6MGStVEGdBHPVwrLCl1q2QCFASTHbx6zpjcBODb+Xxe/gL4JnD8IGqpG8=
X-Received: by 2002:a05:600c:54c5:b0:43d:10c:2f60 with SMTP id
 5b1f17b1804b1-4405e4b88b4mr16181135e9.24.1744813459758; Wed, 16 Apr 2025
 07:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-3-zhao1.liu@intel.com>
 <c44eebb9-1252-447e-9262-e2946f90f01c@redhat.com> <Z/97xG5VONqmlK+7@intel.com>
 <Z/+j3be+ZT7G1ToL@intel.com>
In-Reply-To: <Z/+j3be+ZT7G1ToL@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Apr 2025 16:24:07 +0200
X-Gm-Features: ATxdqUGRX_V_bfTsFItme8CeZJ8Ner1vUlayCbnxr1bv4fc03jO9yQpKnBPeGJs
Message-ID: <CABgObfZVh1nAjFd8m4hO8_dfW87cAjYgBC9_3Mve5pXWf=n-mw@mail.gmail.com>
Subject: Re: [PATCH 2/9] rust/vmstate: Support varray's num field wrapped in
 BqlCell
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: multipart/alternative; boundary="00000000000077f35f0632e60a4d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000077f35f0632e60a4d
Content-Type: text/plain; charset="UTF-8"

Il mer 16 apr 2025, 14:14 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> >                 let access = v.$i$($crate::if_present!([$num]: [v.$num -
> 1])])?;
>
> So, the correct code should just check array[0] as you said:
>
> let access = v.$i$($crate::if_present!([$num]: [0])])?;
>

Except I think the if_present! call would not be in assert_field_type; it
would be in the caller, i.e. vmstate.rs.

Paolo

Based on this, there's no need for anything else such as `Into`.
>
> >                 types_must_be_equal::<_, $ti>(access);
> >             }
> >         };
> >     };
> > }
>
> Thanks,
> Zhao
>
>

--00000000000077f35f0632e60a4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 16 apr 2025, 14:14 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let acces=
s =3D v.$i$($crate::if_present!([$num]: [v.$num - 1])])?;<br>
<br>
So, the correct code should just check array[0] as you said:<br>
<br>
let access =3D v.$i$($crate::if_present!([$num]: [0])])?;<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Except I think the=
 if_present! call would not be in assert_field_type; it would be in the cal=
ler, i.e. <a href=3D"http://vmstate.rs">vmstate.rs</a>.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
Based on this, there&#39;s no need for anything else such as `Into`.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0types_mus=
t_be_equal::&lt;_, $ti&gt;(access);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0};<br>
&gt; }<br>
<br>
Thanks,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--00000000000077f35f0632e60a4d--


