Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1060CE9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Ha-0004ta-Dv; Mon, 02 Mar 2026 05:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rr-Qm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:40 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-00061x-1h
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446414; x=1773051214; i=lukasstraub2@web.de;
 bh=HwK2p4T1L+s5e+s9n+9hT46e4+ZnKxyeq7tjYkZiYtk=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ADfR5YCD+99m/4M6kdabq1+iBi2O7/Ao64a30Uy0znoIvIYP7B07ZFJot9ni19F8
 g5T54IYzXr+6GDyna2r3VIbzFOF5K/xiJIiVwU/S49WS6Wk2pcjyBDMFk0oAj0oso
 OQ5iNz7rZiIb0kfrLFndULK8euIiiLx6ezK+XuzK4XyrN72gX97HQ+Jx1iiqgcaQt
 L/dpJFgS8qfrCaN2iajQOh6ES+02e/Fn4jr4Zs7DX50SRCLhO1sCNFUy9Qyky/xwj
 YWlK5HEwtmUOUm/XU0VCDS4/YiFG3/hJxPyWH9RI4BnDtlV/u38iWyUMciTnD6u5h
 oktO6ysEyIcR+qH3uQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xvy-1vy7Gs15zw-0087EQ for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 01/21] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
Date: Mon,  2 Mar 2026 11:13:12 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-1-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=1tZjB/3/ppKqe9sB1vbDXigu3FezuQVf4cS6OWdEReY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAEC2QoKCl7LhSRpIQjqxUsFUhcDfd0/DxYT
 Fl1Cd9eLy+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBAAKCRA1qwsonF2y
 WBuED/wPZu//QtxmhUqQLI7BMaLQoRJlqu1rI3IN9kNTjEaYoC5WSEHK2oSbLGfaOiA8rpTFrc6
 kccObG8jN9igncl9gaVAb4anxYnjZhX569WoVFhE/ntSzg9gcrjab3Qoe0oVS0vPNMBzWb68WRh
 sHFiStsbttP6oA37DKgYSBIBD48ClQpEP5BGv2xX0Seq2XmXq6ty7a7IZi632lAHrHNgm9mZEyW
 xUA0gU7xjWdtNqqjsMLBhLGJ/S5AHjCFXdPl/SK/WGAhh8Xy/xcrtBehELIeYDVLoCi6U+9qQrB
 P5upQlJSrAridgs7dQd4oXfrIza/RiQgTTflfIVrrIb6JBq3roMmhBpirxER1Ij7tyvjSoTkOce
 o7l12LylN5EufXLSrvuBgvIL9F3nis/ljEwfwbMI7xwM8w72M0r0Oz/iDjnMDkd0nM9gzE3m0WG
 Hj0afMW/9dekF2e9yT2JN1h1IdI4RRhYUZBNW5dB4KbEnsj6PGSv0Y0qdRZPMTIKIriCv/MtxF7
 eTxvKjUayvPlMSyoIHz7Zq0crX/jxLeadBI7iSvj1rHA0Rgq0rH+mn3EUwAxy9FmgwdkDXANo6Q
 6bTOePm1OQXyRot3FgEBS5nm5/ZQuc8srpANF1LuXvaDYMz9r+uJ8ViVqC4fgRejhNvlIi7INt0
 LpWhwHi1wizf9GQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i5nH4FsM2xz8ouqS+aAWMDeuzbjNGsb68C6HmFPICImy4oE+vV4
 HUgi/vkm8nGdXdC/iSk20pIC5sbcYYUr0mSN0/h5HwGCWglNbiKJxhEXAgQ1HDlaRjiXXJq
 qarVMYVsPKN2f0gmrR5Eu8a6TmSyhZRQ4+oG6CL/DZqqBJqxoVrY0pDaXCyJlcPw2o1C9VX
 mWVOKYlvVFrqGXJ2CiLjA==
UI-OutboundReport: notjunk:1;M01:P0:RyfQLX/H7VA=;lwY8hXXt6zHKeK3/XaJm6fgeOkc
 Gj5s0g9M745BlLp5OOpShnCILejVGjbntR87nOGZhnudmHN0oXZKBnN561IOorx7c9N9i5a2I
 VqfvQPPl5JQoLSwaxyO4RYcxqQFHZuippaENzE+pkqSi413+xzpgxvVeRBM7KR5f1lThTOG4/
 WACskZJ+DFv9oFiJL2sJbEbrT2G0m9cQjvdDdzmULnMb+dkxGuPLbCyfdW0g6Bd3BM1mBKX3o
 +rRxrQSpS0GEcQYl/+98akTd1CjExnb3jl3BAkwYukAglGYQu0l+06qwuuR1NUOHaUsfg5Ikl
 WQmUtLNNeUq3WAxFwtfNNn0vVB2bgwzM2ylUkCf7oJk6AHhKgLqkzeQNUWrUBFszbxTychU6q
 9rkVGZ+A48oNfX1UF0Tq/N+2X+fARF9eDYDAQcczjjQGjFo1fWil7Zhgv3JPlKGK31E95vEnB
 7gfJ4+Q0pWB5YpXEfy6O1nuVsV3/g7rkN+M3a0tiZukuycYuwAqULf1PR4lOesvbYTrzKe3iQ
 cIt6zfXA4udhqho0wVsI0pLjNN+lLuKlSGKZNysFuO/EUeo5S6nIyIF8UqDQxboWfcfk93nei
 wOaNHgQ7xW1wfIF8ahwikjkysk80V7gjTnqn5OZki2ZuNCUd6GOhRgPZJxh8RUSZUo2KJT/5b
 vz9P1m+9OY91XbBPK3AgAqDG+B4h1XZvf3WWDD4Oo2ppdjr/HKDUJjsUfyPsCBOGKyzN9DTP7
 1+0jvhjxeSX/LXmYvcK5w0oc9DJzCPGJCLBvgDl25KJoHZC1MEwp4UYYDBaRC7QdcjbqSNt4h
 A2AiEbDycBOap3MqHstaB4u8oUAWBuCTgkCacXGdu14x3etIjducESqduN3rcZN9EPzBT6YUb
 OeLTWLk0E8DE3vC2KMoQlx72GNzAszL8daeGHQZCJhwS4JEY/1Tk0yzB0KD+GrzEMvBh8YUst
 qabf4zf9/OJ9kJVipQ9CzsZUb093dOKa3Mu7nccf3BerI9S5t3P+ylriJ3sUze4rAmLJAY2kT
 BMajrgxAJy4yMAoDBZLgO8bonyX0ZYjxKgkmwldMNkyIoj8dbPqbv5fH//ITvR0tafJQNyToV
 eRUcIM79oxAxkc93MDO2lXRlqLAsNP0Vh73YkX0bO2PxtJ7z0o92GsLLAoyX+Jo+oBIhTpZrF
 eZ1q1Wev31TqPU0TCl4LzOX16E++IbXyr2kv0pJOjz5dvxMSpRoy3d2/YngxGM3WDmFQ4BhWF
 sm/5zNVASuBWezDVREZUJ5/0/XfHCq8tyiTT24wTOO/TIGAyq/NFmlR9rUjLYcXGLvWtdjh6W
 Q35jxrDxFgBQa7WSftprrZvZRar3xVFWjGWn0cnj7AX3TXQk6nnRZEs/ajdyR+jeFtqtunBL8
 DvGOlH6JatYoE4A2Oljb2DtNVtMbKU2Nc2tx78XSRAoV/F/EAS4swadymLyJdPm5gR+TM6ZzP
 uAMeTjRr6TLbZly+vdtBnIGr/mw/SU+ZHy4Ub31rE2QuY8PW0/pmZARS9nLSLXRtdzl688LmB
 k3AVT24GSkUWm55v9Z49qGlF4BHkB9Wq67skyzHdBPJcuVnwlTx0sp80iqCBusDkdqNO3UZNw
 Oc/BgfzkGqtIwRg+kfBvV6Pn6LhwPscbsHOZLoLj6jtQ4tw7ikMY7kd00ICYv3qkrfSwcjAeg
 pQn0u12iZ9zuGhiuf8G7Y5PKyx2H0rBjBEmK5C582tFgMi1R1pFel/2UFUtbnqGlfmHITCVqA
 2yNXMlsNeFS4HzTNgY/hNpVkh2jMIziRhBWdSds7XqnpHbr28tcAKVcYjNKH6/VyNKfDTG6kK
 c3O1ol2IINGBeP9ml6oZnFkA3YPjicrx+c8ncLYZ5fqKOUrGElaE6BvgiBXDIepoU57PV0NMo
 w4B00djDz+6dHnkxH8uwyTu2VFA/+IzNl15Wd3gfT+EqBQM6BVGfAoo5VrEh3Oj7yZQqA1cCz
 rbCqzmRT8or9DvdtZqOzdyxNP5Lz8omIb2phAzH4Vrzgj1DZfwHDs22WWBhNA+NeoPxYhDTaO
 8Xaex+7xmhjj1frPKP8azOe4/WWsWHrhno7jh46xfXMKsKBfZ6c2dxAG1G3W5SPY7oljXnC3w
 K+0syHSDcgDyJmRVMuhkSKH47oS/mQtokD5YCnXNoZIS5kKJyFszqEQ65gk0ytZXCa6Y2d89i
 Ayk4qdR6l8PCFJCXT5sOuv+Vs9k2ww31UR8v1YOdjrQZ9PEQafoC8IHLxKLBKL1plmbyc4yQX
 hCXSxTLK0S33XoiHVNX+GVycyhzxGAvB4Yf/QJvpEzlejDNtdBklYbnk/VM/RpNptoxwLkRNv
 OKLVGF7E6/S08FMT90+tqd6paZ+R26fByEv3iN1s21DrjGb9MxVmyro+fy1ui0zCPDUGBLGW0
 nGSN0JmF+gCN9Zv5QHTzAfEl86mueCHwrLDuO9AyRzIdoDQX3Wm7A32GAqBzU0tgkp1c55rSw
 eZh0o9UCYcBOFj6QbqPBnWy0psdmd1r1cvh7dS0LoRcwyGZWS9HDQKYqEewYmrqPDCdLX0f6o
 7rluJq+p9DLI2MypulMu7bthIGRnZI5ja6Aq+eyLPlzlU8h9iXSyJCBzl5d4Nk5TRV1xNl0th
 txzNajvYgLfqY5CcNc53BCoPTFIbJzPMTQlcl5bvGOpcIhqenFWPVwrmeSfjsDKeVReYc8CLW
 8L4U53/Ij+wUVxjB+rSeyJ4Ps7FRO58vGj+tMnI8tSM73ndZgbse+dT2t2MBirQKiSkA8DDPz
 614n7nnu22WaUYqEpOc5lANhKYzYYJ6jw10Ul5OSWStHonSVVeAMuHUz0hgfxs5v3q8PcGKqC
 Q1hZQMlespESSJJYLsG2qioWXGvr5CpMJsKEgIDykHQ78PiaA6IT6P2Y+/wXTo1sWiOISwHfs
 lLFMiLsjAA3rSUWOtzpDNL1xMy5wuFS2aj1xsKYa+Isbsnq1XfqPm3/pmS1/jATVqPGXQclJE
 7EGTpyAQAor+irrHnnAUV5LwMEr8xImSbRsYr/PiniHJ1aHS93COHGKBRN/VBdaLOi5+XLOzS
 QOCPFI6SMy0WcyAWsCHLGH7FZkEJBZATO6UhwYXOmGi3n+n0OxWF4STxjt8/YnFUJ4bLmClzG
 nZNdGhniFq9wXODwXw8dPhqBfs3/f0hkqY0eXeI3Q0/swhsu63DJT1fOyJtM4NZ4B8oV00mkl
 8ITQe0MLlXjoFCCO8HjWxg/l6mW3VFizyFLoQbABZ1mI57pVnRbwdEPlt/powDzOX1qFKuqQo
 dbL+O+/FupKpXKtnVOvCc9dww9OuvoxCzudS2RilsepkAIgzAJ2ln0HPKH6mm5/gbhdV9Eqhz
 SIyuyNKVPcHTd1aTbbfkvPVydsrsJVdRp+I/Ovvge7Rm+mjrPNw6LTiI3/Ly2ROGwk29ts8r7
 sSDCnLS86rvADn1CEFvLxBpFbB60CxRINRlAVW9QLF/Wf50jKyL6thZ7Y3vaVCztERlqLiW/8
 auXRTs6OSMta+D5s4QwFhEdWdVjPxKUw0gO3+mGNmlcuszcV3ikhLIX7LRhB18p5cBQ7TMaSe
 aDUaAph+UYNJjXtMi3yWj/qNVbQ/vqRtyh3M4l8B+TGv1Zw9D4OtwX6YAjMSDYB6klE8LzLDP
 CiCzmVnJeTjynsEaZdqMjpwM8NZbdiesMROTvs7UOTXos2gSVGxGc9+C6mEsRDcIQ5375fpTF
 CNGJ3n6CcLUK+T2jk0OteymIglMl+OadR+1zuZPoOxgySJH4I8+Yq98hixvljHpRjNKcSJKgP
 MHm43gm+pxbyc8jfM3wLBtKSmVbUxUADBXcKyMtFfYK1LVa2F9zbDmugChkIyZ7j3pByrHCxK
 AqIWUEVjfzQ88bQukNgTboSmp1QigMIRaum7T0BwutP6RVif2LdQE1UpqUcRJUS2YHnLarwZS
 y1y98KM0qiqZoMIQwecAxP5Wa2AEoXYHVkLP6sVF6Nm2R4M/aj58awxMovq+aHPSxbs2muAmD
 uJlUYIhyIEcUqKOAqztrlfbOsr5exmWnQE7DKJHSlgMqm1TvpsLtlqUU83jJW6I9YIYdNP8l2
 8NO7IebOQGms5w01wZ/iM8JiKQESux5NXWG+7zbE7oM/WGJ9FJQ4yLYfnIAnkQ2EQXZJPz+zz
 2ToEe/tCcZt8gUZ7WZZG956G+7KG3Sydb9azVjoY7MHffN2tBLkccXSmHiyjPmfMXNiD7KVgE
 kNMBwsGhyOOc8R6ESM3pk9FJvqdBzcB910k688ysRXvuHozHfWHtYwQlv8Ycdg/B/t4AFPQZl
 iPsIwTgf4LKhIrgtVigKA8lI+746o0X8NfG3UitSIVfpUObn8WJ3Z5h7sDxM4z9DyJMRO1gCw
 zjSkQ8EJYvTfXwSutnQbVjQvqbO3sDogWISbrKPjmQtxhLbt862DcGlfkbKjJsxwaY5TVxUsn
 m+fFK+nlC2SEF9uIyMvN6RMwJyMQBeWBstLFM1zGkn8K5L7aRsCs+8he0kW9FtzK43dohUVFq
 i8Ri2Hrwr3KLN3tKDfH20dRBjo24Je8dpnqyaz54hlmB1g0jTJkJCJqow26a/SCEzuyNO1ohb
 4chj4uehIRsP3URsRK1HTA3hK6OiakzJg2uqdXzfYHet4uYOkQ5pCJo6W9fclq84TBCi2S6i9
 53J+yrbVk9vOfQiXf/QnYaQrCCyigobTg8NrMu26TXZ/c7jZBD9XDMURvE4PPdusWpxwYFKYh
 6zMhlKaJxKL2cZPxSGDVQQFc+ywMUa8Lcft32TaQuJSVcYJZgNCk8LNt81+S+O3qzHkANg+Aw
 R+UQ6kVZwfC2aYIew1vSGyUl8Xv2lYVrecIU5Nnx9i1WA4kOgFlZm1C/mVLsc0i6fgf85dYKA
 87DeCYEsRU1E5FtByPEwsH+8s7uzZ2/vAY+jm1AbgqXbrOMZzDd9b4Z8Z9s3CZtgrX7u0LwOS
 EAw7KzLXgh7IW/zR52Kx5RZpoVzzQI0EgF1euUWtlQFAX5QFf1jqxlVwYeRCZbk4stjxq96Tb
 7eJOjnsSCJOQeyOvJbuOivCMvpObQteYsZr+oKt9DGA9dy2ORpXmjUdf3uE+EMHDAklQrtQXf
 7syUz2K5fiGbsW6wv4uzboO7AOgCIo8PpfycVegE4TPH3ToYKJ53BCtibkiXAhojc1JhA==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762cf2ba24d6bd8bb72421db1325bb1908..ff592384b366acc823f19a6596=
ea8f32446763b2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3870,6 +3870,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


