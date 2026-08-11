Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B02FC5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk7y-00085J-28; Tue, 11 Aug 2026 06:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk7w-00080q-4V
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk7t-00006d-2K
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:35 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BAM9Ft027477
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=cUqiTI5VHBbOKclzTe05KN
 XX8nCzCrAnpabKF4IFnu0=; b=f9E7MiJAGS2kcZGp2YQBREkK+vX7PJBmea8Ij8
 J+okeBmgP9V5y4ogT7qvxlg+halNFuEWELAso4Hbcb2oN7eWVdTpyzF1oea+KVHT
 devCJYYtqXxE7LXFj2NCzO45ttVZbocAYKM9eL4YBczeIrL0r0rKKCMlYuKcrySx
 3dH2ntxbXcptOOF60YYHrzrIArjn7ZbgNVAT9KmzIJBxRYO0rQY+zEjOX1LRGHAs
 w+X9+ks/ux/dCQnOLwnDczBzU83YbGOyKwkLgyPAPDnr7tIFi5yi8JbpDB0Xkqiw
 shegoIdO3TU/cLWWOxAiy7T0udry1SJ8mJWFxX3iXtS+J+Qg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjsktax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so52885621cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445670; x=1787050470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cUqiTI5VHBbOKclzTe05KNXX8nCzCrAnpabKF4IFnu0=;
 b=Qd6r46zJH5F4plQJPmmZxerHKa+PlE7jTik9qYq7DjBXmARGqrQkBRlOHx6sQlvPcv
 2P1ShZdzoDGoS/8GKAYYE+A58wYAHHyQx+lWsRsxd9INzVXInNP8ok6VHBcYgikkStJ5
 scyAwUTB1vBO13gZvlKuoJhTkCWN+3QG/6HZIy2jfrQtDbbU0OntqOO4KVOowpIsUYOi
 Nxi1OFhSL6zkgsGD/xNXmBUm2Rj4uvz2JmX6RjYdHUx2GiP6w+dBpt2H9LzhPAzOs0ju
 ZtjmgBrqIaPzb1V6rPJHpKYkw6mlt1Rnq90Ik3tQ1hd0K56ir54JqUu559alh9uDeCWQ
 WWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445670; x=1787050470;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cUqiTI5VHBbOKclzTe05KNXX8nCzCrAnpabKF4IFnu0=;
 b=g2XmHPZ46g7Ss/wClYjupUEd2jgpGJWZVHrP3/NzX/4lVabSLzPFras7MocaFSydPS
 ERTEqojFzs/cF9+yVoVuya2IpBabvycqgL7dlnGVjqXAD+dkt0VehYWQ05mg3IpoSRFe
 TX73RMak2+hsS7pW5PRVfDFVMc/NwEl1VNEFLpCTvpMYan1ZmwJMeTIsdeEmgBNO12Tc
 csZdUD9X1lE2BnHfGUmzn+sj8ZCiYLVI0qznMqxHn2uL2Iu2npp79yxsjATCSrbTyxhb
 Q26DKkc58RS1UHwZ5xxPRuroBp5iGjZhVQZPZCko3EtSxRYay9My0O3g+Rk0fR9reRjA
 gRtQ==
X-Gm-Message-State: AOJu0Yxj3hB10onbYVN3pBkxStRcqvvoS9FPAmnTB9FIwQBzkPT/y0cb
 /Z+FkJmx0FG2ojDoipLo3l+B/3FDEvRIq+q3/gphGLXFVnoSWo0wkzyIwL0KTvP4xRTIoq2hGjL
 DoieYzy9iDuYc5C7xfr2y1fU+TaN1Vmnwx+n3G6ItJ5kbPRRSHZZPwQHw9RGTMjf2Wg==
X-Gm-Gg: AR+sD11rkFRvS2Js0JcrGZm3DwGDLsSIjbXtcL/9cYVHsoAeLeWQ+BzCG1sZLMm5e6z
 706D2GZAd7eWEQSjAElugKn9g7yJ/ZpACu7zwLKv55CAVZNp8TwWyA/JJIJZ082FN1UhSv3ATnT
 KgYRoIKAOHOE4gdOuXC29jWnGUYilWFEn/6jp2kHaAR7Zah/zwvDBMFXNjJ/TqEHDe3G58lACNU
 +Z24izZOkleYyoEWuGVQ2o6vLud7a1R1SYBUoXedGOHNOM6T6ZB50avv3zz2Mi/UHCsy7Od7Zpc
 XlaMbIu2k2JzEpUWtNVFDiW7d7Pnn+C6L4edOZCE8fObpUGF+Rw1dYwEoKMgOKqYQexjbs2Nm10
 tmZLrsXDPFRj5ppp+PzIrjR+Yyth1P4yxTx61y5XDcLc2x8A=
X-Received: by 2002:a05:622a:488:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52d586751edmr14110901cf.39.1786445669632; 
 Tue, 11 Aug 2026 03:54:29 -0700 (PDT)
X-Received: by 2002:a05:622a:488:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52d586751edmr14110591cf.39.1786445669235; 
 Tue, 11 Aug 2026 03:54:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977ea5440sm18121175e9.3.2026.08.11.03.54.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:54:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 0/7] hw/nmi: Disconnect of vCPU and disentangle Monitor code
Date: Tue, 11 Aug 2026 12:54:18 +0200
Message-ID: <20260811105425.7429-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX13XlGhRijB71
 ZqAn+10lLhi8NazqtP7MRqt9BiBq11n/WpRXXTajTm0hxATiqusksr7kQgMsEaT3pMXUzp1V8mK
 sGv0aWpysVHaMG8td9kwQZiPSWWoPYU=
X-Proofpoint-GUID: NdD2Dt6NcRMajHNuBBZXBRJlAGq0fYKA
X-Proofpoint-ORIG-GUID: NdD2Dt6NcRMajHNuBBZXBRJlAGq0fYKA
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7aff66 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=mWcDCmz362VFAI59eIAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX0B4hRPfOfbzW
 HxhdH/7jqGXdXgmoZk+gtS56npCYGLK1XqUZe0fo4Odsw1wrR0MU9c23vGpkXcyVwp++h9/mvON
 2GzolEwB+3EmzJiMcDdbaDPWgwSiJNIjhoS3iGC1S+8hICic7NTxnibnPsXGmeWgWCPLhY46Zyz
 BVFQ7ubSjKC7m22V2dEnp8GDS42MpXr7madeMrUgd82N96CRWoMBi9vwjBch73YoTBssQHEHy79
 qYCSi+plg+U1W9QAkO6+TRvRl7Tc3HiNgxraSM4MMjRWEOBewiRhBYVZQGxYUm8MktsEgo6tSGM
 /0/qU4kPS7mWr6nHJnrT/aigZQ82T3msGEgK3tPhZ+MlLMTqPRhX+WgsnY2XF58x2Lta8aa7jI0
 9GVI5VlY7NuICrY3RC5lh4O6K75P8AO3XfSdwGdiGtJWm5bcFnhFkG12DXRv0sh0TP3ihGt9iiK
 zysZXu5S//FA2ew62SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Have s390x always deliver NMI to the first CPU.
- Remove the @cpu_index / @errp arguments from handler.
- Rename API as nmi_trigger() (since not monitor specific).
- Only deliver NMI once

Rationale described by Peter in v1 [*]:

> The current hw/core/nmi.c code is a bit odd because it's partly
> working with a cpu_index and partly not: the code passes cpu_index
> around, but in practice for the QMP command the user can't set
> which CPU to operate on, and for everything except s390 the
> implementation doesn't care anyway. My impression from the IRC
> discussion is that it's not really necessary for the S390 that
> the monitor user be able to specify which CPU to NMI (and in any
> case you can only do that from the HMP command, not the QMP
> command, AIUI), so getting rid of that weird inconsistency makes
> sense to me: and that's what this patchset is doing.

[*] https://lore.kernel.org/qemu-devel/CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com/:

Philippe Mathieu-Daudé (7):
  hw/nmi: Use object_child_foreach_recursive() in nmi_children()
  hw/s390x/virtio-ccw: Always deliver NMI to first CPU
  hw/nmi: Remove @cpu_index argument from
    NMIClass::nmi_monitor_handler()
  hw/nmi: Remove @cpu_index argument from nmi_trigger()
  hw/nmi: Rename nmi_monitor_handler() -> deliver_nmi()
  hw/nmi: Remove unused @errp argument from deliver_nmi()
  hw/nmi: Deliver NMI only once

 qapi/run-state.json        |  6 +++--
 include/hw/core/nmi.h      | 32 +++++++++++++++++++++++++--
 hw/core/nmi.c              | 45 ++++++++++----------------------------
 hw/hppa/machine.c          |  4 ++--
 hw/i386/x86.c              |  4 ++--
 hw/intc/m68k_irqc.c        |  4 ++--
 hw/ipmi/ipmi.c             |  3 +--
 hw/m68k/q800-glue.c        |  4 ++--
 hw/misc/macio/gpio.c       |  4 ++--
 hw/ppc/pnv.c               |  4 ++--
 hw/ppc/spapr.c             |  4 ++--
 hw/s390x/s390-virtio-ccw.c |  8 +++----
 hw/watchdog/watchdog.c     |  2 +-
 system/cpus.c              |  2 +-
 hmp-commands.hx            |  2 +-
 15 files changed, 66 insertions(+), 62 deletions(-)

-- 
2.53.0


