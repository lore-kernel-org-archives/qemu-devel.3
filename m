Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09057D4921E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1Yw-0003LA-Ny; Mon, 18 Nov 2024 08:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tD1Yr-0003Kw-Py
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:13:03 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tD1Yp-0000s1-DX
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:13:00 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-514bb6953f4so19959e0c.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731935578; x=1732540378; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cxY6fZIZ/MgvPb7LwvIRSC9rB6mQzxRqG3NwIYp5njk=;
 b=mJPjNrkcatS9qLwzkvsijtxfGbbEnvTeYqZnMHG5FsQKXT8Cb0RBFMOICItLq0iQb2
 YXT5j0v9g61R1hauuF20Z90iBXe7Y5XhIAJF61bFzH4T2DbeaVIEFy1ECUu63inpM1fF
 To+VjLp4g9KXDH3xqdliSNNzcBgJ4pKl6SxBCNVM9CTjImQganS5tmEttt5LAfLhvhO1
 UluCNtL4CtjP96BgGOxC6KmPvBBz37WfzokMstGoNVfYkH/Gx8cv5z8+f8sI+U9aqg0F
 N33mx0et5OeI5xKsSM/VlcTrcVBTT+mpVVjSkM62tbzTJxgHwrKUdAi7v/ctsfc4KX3h
 F1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731935578; x=1732540378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cxY6fZIZ/MgvPb7LwvIRSC9rB6mQzxRqG3NwIYp5njk=;
 b=KC2kVqRKVh+8j6LDOANSp86CXpgc9JBLGSNShDYVTc+9X8ASYG5YqnhhT/PZ7kzRhA
 H4EaTL6qt0AtOQsKtWYjOeMWNQzZ/I3Dic9wJQcj+anYIn63xZ7a1QNZ1cM37++F+8/G
 kWBipwwqbJNS7fyQeHMXMMd1cLywmLO7Du72WyWNF+QsOJtrM9EYt+qf6xOgN13jr1Qx
 EMSv0Zdx5ictFhwMkzy0RDHScBySkztO5vml1pjS+3EOOc78RHqcq8c+U0o3WASvnjy7
 K8aUH/rk9FDjwm5leLwbajBA6LMRhXcGzUgLlGD0IrtaCA+LkYz2X28O142C6vp8q6Tp
 4UzA==
X-Gm-Message-State: AOJu0YwZK4QhfyYbavJrfdJ/VKXOo+odOFc5Rwo511f5FrGK6Kd3Njnd
 P/0paduDS+tIf94iwZSG89PH0e6OPlfIq9tCYzI4oAWz+t8Z7k2r7t4ysQMgcRH0Px1KFO3MygJ
 OWnCFqgBY7ZQCcPAyBl95plPFKUDdaA==
X-Google-Smtp-Source: AGHT+IENLkhhFfv23mg1qEHyuvLQkwanQAQ2ZPyYrfbilgJuoVQhYp9OA6fwR3Ads40tKH5eUsRk+CT1G8JAhvVycdw=
X-Received: by 2002:a05:6122:2015:b0:50d:5095:f02b with SMTP id
 71dfb90a1353d-5147829aef6mr10538428e0c.0.1731935578084; Mon, 18 Nov 2024
 05:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20241109123039.24180-1-dorjoychy111@gmail.com>
In-Reply-To: <20241109123039.24180-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 18 Nov 2024 19:13:03 +0600
Message-ID: <CAFfO_h7Gmq9vQYOXB255c4jWK3KUEF0xro53i0qior5XQhqbNQ@mail.gmail.com>
Subject: Re: [PATCH] eif: Use stateful qcrypto apis
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, pbonzini@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Ping.

This is also a smaller one that needs to be reviewed.

Regards,
Dorjoy

