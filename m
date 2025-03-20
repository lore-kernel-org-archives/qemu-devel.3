Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2207C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGem-0000M7-M1; Thu, 20 Mar 2025 10:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a17877581@gmail.com>)
 id 1tvF0A-00077d-Qq
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:27:58 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a17877581@gmail.com>)
 id 1tvF09-0008KX-8n
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:27:58 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac29af3382dso126362666b.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742473673; x=1743078473; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HXwJV7gnT3iW4azo0gisDzMU4cMIpeAMpaYop7z1jbo=;
 b=aFNCk4CZl9fc0GKBx+OMs4NcE5W8pOF6FJ/RophuqiScmzyUrSAL2WMKuMHfEKGca1
 wwm6o48DADpkVmX1NybYTROcS6heE37cWKZ+RkO51fcR2QzUmYda3clBaINEO0FZmCpp
 SOV3Vb9/EjnaVJ1mvNlbTWBQH62NyTqNEiLJa3rhFsE2HZMV52oo6DYLknBI48RbaL61
 C6tp9MObesZYZDTo4Qjug3pCmQlF6OzaoePDIevyG5XL4WyWqJy5AOI0NF6N/WPtB156
 70k52iQ/6g0qx8CZYeOkeCMtnGIUrL29BH3Zz0AZWGsA3so0TQiSehZnWBS7QY1qwp1n
 MAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742473673; x=1743078473;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HXwJV7gnT3iW4azo0gisDzMU4cMIpeAMpaYop7z1jbo=;
 b=Tci//qdxN/gaVh9XN62cc63x9F+K5DJ1pWH2Kku3c892aEr+ZQ0CY5WWGrTVp9l0bR
 4TUGQAIzbQ6NxsA4CK7Z8VlVmIBFYhEV/tl+h4dy1HeyXcXT9vQyVEw+Bt6oSuy5XXez
 DT9h65Pjhx4S7F+coZJXuK8NRjMGkZPwMMpQotsrzYW1YzouWlqh8UMMEi99m2XRUeSR
 7YV0mKY+mINT7PIrX4E7wxuQeHRlDgYU4zKObysRx1mgxOgdZk6+IA+hWKYUs8KYuyCN
 f3evCpqkRD+84J1krToxqdVtIALpnHGlVLVxVjlUDGko+bj4bEzVfdmb2vFYFOO+Oio0
 Qo1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6Edg0jLPfZfQoK97gdFgBLRVL7NBGKbNW9JK32lapDB8wKCu7XQ9IN6Pc+YN5Y6HPYQxCvTz5NSzi@nongnu.org
X-Gm-Message-State: AOJu0YywnXyJqRYDcYM0hVESh0YiugrOOPDLSxhjZRGtp6wfkTCdNXwF
 5bDb6OH/BKgEBsRj/JfqZ/anknWIExtzbh15/LfyunrQYCL+O0V4wmPCyw8wHUBk4IjxnX9b8KZ
 /85WXFiT3sHT3iLIWLtgCxNDyr/0=
X-Gm-Gg: ASbGnctrVgUxj827HSz+h1BI1HZtsMGwAAmafGsiidb2I7R1Atomoi2NYpN/bBC2APM
 tbP3JHxr02Hl701eYdQh15R2Z9itFevwVLD9z2Jnc/Wxk4Ad9pJn6jcHKVNWB9CppaJvujt/Q/f
 rg179dT9kgv8PHlkyfxzrfMBPu8g==
X-Google-Smtp-Source: AGHT+IG24aCjSHah0RFizr26czy6BP7YVHBCXoHXnauHp0bK42t4oX8dbw7ce3mQhnTab+tS1IrCHSxbCots22E6al0=
X-Received: by 2002:a17:907:7da8:b0:ac2:a42a:999b with SMTP id
 a640c23a62f3a-ac3ce1d4b6emr335581566b.52.1742473673027; Thu, 20 Mar 2025
 05:27:53 -0700 (PDT)
MIME-Version: 1.0
From: Ahmad <a17877581@gmail.com>
Date: Thu, 20 Mar 2025 15:57:39 +0330
X-Gm-Features: AQ5f1Joe8tdm03nzXzIBezs4PXfdudiX6OPy296l5wqWh7JiMEM4Hg7ir_Zzmwg
Message-ID: <CAA11P5r-sUf+FX6SMKToo1B7Key61756rM0gz+S7EivEkSC+XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs: pcie: describe PCIe option ROMs
To: heinrich.schuchardt@canonical.com
Cc: marcel.apfelbaum@gmail.com, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004fc01d0630c54474"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=a17877581@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: 20
X-Spam_score: 2.0
X-Spam_bar: ++
X-Spam_report: (2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, EMPTY_MESSAGE=2.32,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 MIME_HTML_MOSTLY=0.1, PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Mar 2025 10:13:58 -0400
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

--0000000000004fc01d0630c54474
Content-Type: text/plain; charset="UTF-8"



--0000000000004fc01d0630c54474
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><div dir="auto"><br></div><div dir="auto"><br></div><div dir="auto"><br></div></div>

--0000000000004fc01d0630c54474--

