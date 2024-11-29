Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA21D729E6
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH2c3-0003oo-8a; Fri, 29 Nov 2024 10:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jvilaca@redhat.com>)
 id 1tH2AT-000404-Dg
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:40:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jvilaca@redhat.com>)
 id 1tH2AR-0006m8-TR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732891217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=mf9B2RjgbULpV/473cL3Yo/CITdYJuQzB5zWhNqYFCs=;
 b=cwkXzEYQBTwNyQCSlkKGTT1S5lf5PTxSJTw0Nb9zzqVS9g4CqH6roGKTRGV63d5vsm2wva
 YIZV3h1KmaocIREZg1ShHwW2su2b4r5eGpk8vdQfSrPTVWx7f0pgjhC5pn3CR9+/B+7nns
 KKP4EOuqeIpygDu52TvQIi/sBS7bmRY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-_0bESrm5M3Sxy9R8VllN7A-1; Fri, 29 Nov 2024 09:39:04 -0500
X-MC-Unique: _0bESrm5M3Sxy9R8VllN7A-1
X-Mimecast-MFC-AGG-ID: _0bESrm5M3Sxy9R8VllN7A
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71d418d1977so1232837a34.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 06:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732891143; x=1733495943;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mf9B2RjgbULpV/473cL3Yo/CITdYJuQzB5zWhNqYFCs=;
 b=bv4k37mArlsHzX7snmnZc5Eh7StUUpBIyrl8E07o1b7RNt/r0sRuskbvIuBndSBvvz
 jc9t6+D49jP58m1UnF6AjH6jRc4wlSdQk5bVl7h+4GoZtZpSRmvISGQ7kSE5kc21H8Zw
 /31OshoqTrqIcN4xFiU0N7wzUpRZhB893rlG1M1J8enzJbkJY99AB58Jbu+NUXC5ui6G
 MHyMsX0FjeLnqYkiU7nEWc9cm+pTPcdM/+V0kMjZrVqOrToscmSkL/ebn7FkqF7uPTK5
 i+dhtfEGDu14HF3jLgNvQBs+GJCj+E+zUd+8xnyU592xt+u6WMdnsTWeI+gLMp+rp31Q
 m6TQ==
X-Gm-Message-State: AOJu0YyJaBdKgi4mJBBc1qq/i126UdAPJnO8Zq//MzVl7fqwDm2hPqnk
 MZ9PFGFmg8dYbHUtPqfj8gakqfY4/7HC389wt22/XnZHos96hMR8HhJ+zEMod1RtWKu/P77c4dM
 pqmpWoUXye0QIlKeoKXFakBnslZ5HIgXF1e0uJh/ZJa3QvLe1l7R7unbC8zHXN5h73DAhpuEvEB
 8+r/kdxCL+CyEMytFgnHsj2wDpLiurNn+KcD1ztQ==
X-Gm-Gg: ASbGncuJ+1G86C7t69HowOdArl8LsiJWwpiEQQ/UecJfjVL4ArdqK6/hZW3tMW4vWXm
 KfvWNOY/U4IA2nQlnh4EQi8Hof5oSXRPdVr2mzqJRgy56P/bzbcZkhnLSWL6FHog=
X-Received: by 2002:a05:6830:441e:b0:71d:5c89:e505 with SMTP id
 46e09a7af769-71d65c8b284mr10312182a34.9.1732891143738; 
 Fri, 29 Nov 2024 06:39:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFReddHrwGiO0qEo4/WHxA8iFOAr6LEiGoCSnM5tiQB+ohNtbcCn6yxuc2zBVsx/HKJ30v3V0/7botyxTVBJCM=
X-Received: by 2002:a05:6830:441e:b0:71d:5c89:e505 with SMTP id
 46e09a7af769-71d65c8b284mr10312153a34.9.1732891143401; Fri, 29 Nov 2024
 06:39:03 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?Sm/Do28gVmlsYcOnYQ==?= <jvilaca@redhat.com>
Date: Fri, 29 Nov 2024 14:38:52 +0000
Message-ID: <CAOw09wu31aROKJaYA7igHR_toegozssDXsTBNuUhusoRX+Yvng@mail.gmail.com>
Subject: How to query the number of processes queueing for the CPU inside the
 VM
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000983b706280e29b7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jvilaca@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Nov 2024 10:08:54 -0500
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

--0000000000000983b706280e29b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In KubeVirt, through libvirt, we need to know the number of processes
queued for the CPU inside the VM.

Can we get this information through the qemu-guest-agent?

--=20
kind regards,
Jo=C3=A3o Vila=C3=A7a

--0000000000000983b706280e29b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>In KubeVirt, through libvirt, we need to know the num=
ber of processes queued for the CPU inside the VM.<br><br>Can we get this i=
nformation through the qemu-guest-agent?</div><div><br></div><span class=3D=
"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><font color=3D"#=
888888" face=3D"arial, sans-serif">kind regards,<br><div>Jo=C3=A3o Vila=C3=
=A7a</div><div><br></div></font></div></div></div>

--0000000000000983b706280e29b7--


