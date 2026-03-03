Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A25EEDEBE6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUyE-0002Z2-Uu; Tue, 03 Mar 2026 13:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUyC-0002YN-Pj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:59:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUyB-0003MW-EJ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772564386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldkqWhKG/pViPGOuQtoZh0XEluH/KUMdKjz5oPW4qRY=;
 b=EfOvcmLFlaWMK7KhS4Gl5uQ7EBppoFu5GMfWKcWyKFUf3MulX4UpS9lCFu4UnqDxPN7AU6
 1v/Lvg16HpjX71AJqWXscR6GpRr6KXatzolk3Eh/I6skXrJwVUwJqcULKmRf4xfo4QGqtu
 EVj1wR/TWlS00u3OVuu1LAbnnTzCZ+0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-CYvEieWNOLmOHAhttkF-fg-1; Tue, 03 Mar 2026 13:59:44 -0500
X-MC-Unique: CYvEieWNOLmOHAhttkF-fg-1
X-Mimecast-MFC-AGG-ID: CYvEieWNOLmOHAhttkF-fg_1772564384
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5033b4d599eso531860561cf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772564384; x=1773169184; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ldkqWhKG/pViPGOuQtoZh0XEluH/KUMdKjz5oPW4qRY=;
 b=rISFdCrCuCaUspa6ItazLAtbF8VQK8XsjebE0x9/kUJENvVZDhfxDip8MhHuBnk40X
 CzzxQKvv+iSuZD2TKyH+Wj9D/v86QY7qyrMv7vTx8JOOT5ciDIxds7ZX/u2nhRqQEOui
 vGg8tPPG5MDcZBwXdrj84ZPIaRMMpxx4Xde4Yvmp5iejvLAo8qI5XIVfOOxLW/NADi8z
 8MqY3Hv3up5aaOEwb1yLsBluLMVD7V1kK0/e8sLNCmYW4f9GPqhdiQtyTCLAVGRqd+iZ
 0dJbJ3hOUioHG1EViJPQnz+QDDlDo8DZsem7ncFfo2WSaYtTxMDrDpzcvZFrxsiLs3ux
 iiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564384; x=1773169184;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldkqWhKG/pViPGOuQtoZh0XEluH/KUMdKjz5oPW4qRY=;
 b=v54z1k10P7i/vRLLFf4J1BCnZZAAK5DWLCv0ZxJa5rLeyKXUMYURPV3ga0oG2Gnyx+
 dXhTFjEGkg+7lSj/Q5sWEENhSP4l+Sat8oIdJJF7kUIVIjOfdAYFX3yf8jbQOq7okPIm
 97TN/kqibGswJhgRZct2i9ur68g9951JX0D9iTCe9vs6o+mdMPd4ENCQotumonTIlVl2
 YbnGg/X1+trl6RBk03nOPLrgp0xTNMAJ4HVGJJdUiWDClal5E6GL3kInNF0is4JcbryI
 7HiwH8TinHQxqR/tPH7L4xrIKmVnGPTd9mHMNgEgSt4taitLQe6XlJi/zHAShUPnC8+w
 dMyg==
X-Gm-Message-State: AOJu0YwvRoc5wUb7k8U4OO4YbJqzpqJZG5tA07Di0qHLg7b1wsqJwM3Z
 BJU8yDRNTfoln8ydu2v+5kK8Vbu6ININ5ZfxzgxEsnmA5CUxSiVp3zOV0ntipc3K7mEQLk59E8L
 Dv0YQTElSwmeAx9SEpu3fvp8h+rRNYEStUF0LLkXln+tQcg7J8Fs6Ynz+
X-Gm-Gg: ATEYQzxNOYS4y65hkmKQALhY3r0hfu8Qhx7APKplPVqOXXMoDkhpHMGXtYrOhrtS0dc
 H/UcYo/zLM5Z3rC1x0781Rc1vk0Sartrr+qs2/mgg3DSa+aKyDxcWG9MGkTSiluSl8qz+j4R3Yt
 nxbTNf+lBjXBfxquNvIsaeHybujyFp/wSyqz8KlQd+XCaz/MlmZQxDQM3q5RmK3ctp4TLwapZ5h
 WiAUGedMxsbZ4W6Y692l6URsLQ5XQVgu5ougQ6BV+1jReHHVDW3RekRO0QVkTGWlUJK6sKoPAD4
 8DBFmQ4MN8aGhi5EnYATD3mPIwWNdELnoufOHgeIT6mdjz7MvlyegMWshKISK5iXXvYz3OaSu8j
 QQ82JWnXG5XWQBQ==
X-Received: by 2002:ac8:7d0d:0:b0:506:bfa3:55cf with SMTP id
 d75a77b69052e-507528822b1mr229496161cf.6.1772564384336; 
 Tue, 03 Mar 2026 10:59:44 -0800 (PST)
X-Received: by 2002:ac8:7d0d:0:b0:506:bfa3:55cf with SMTP id
 d75a77b69052e-507528822b1mr229495751cf.6.1772564383736; 
 Tue, 03 Mar 2026 10:59:43 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6869f5sm1629087185a.20.2026.03.03.10.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:59:43 -0800 (PST)
Date: Tue, 3 Mar 2026 13:59:32 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 04/15] system/memory: minor doc fix
Message-ID: <aacvlHgJtwOL1QE0@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-5-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 02:59:49PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


