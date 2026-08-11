Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC1EC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpDl-0005zA-5w; Tue, 11 Aug 2026 12:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtpDk-0005z1-3F
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:20:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtpDi-0006Su-6I
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:20:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWVQ91914013
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iB/qQSYRhbg3Mhm2Uf53Xe
 0wpCtWdBbA0N1MS7q6eYg=; b=JhqlkzCuvE+D1ySCCvk9Jg8t3oWl1kcZp1wMoI
 E1bPFDgXPoO82ZlVC5v8VbcPOTjjKK5d6k63islCm0PqSJmx/noz12IVH3O/hcFq
 RICQxdYju6aeM1A50jxWZ2U67oOMIzZ903bmy3sZ5ftgC6xG/Wop61tFt3ZYdGOH
 Ep3bEfyGDPFEQWNwhz6W7tZZq43TaQn8wV3xqZ4zrVUPEY6lHNA120M9kapO7oCU
 Qs2Tl+NVndoDo37429WEGYRfpPUG/Sm00NGiJ5HT99j50eMN//vW/fumWa3JH/1l
 Hl49rdzanaFsLtlVXRdNDqqG7FxjA9BXxz+vcbyfa5X9l/iQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049brry2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0e702df8so689041cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463375; x=1787068175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iB/qQSYRhbg3Mhm2Uf53Xe0wpCtWdBbA0N1MS7q6eYg=;
 b=KtCGcUxK27cBj7pLFGRQbQzcVDXLZvT06n6qJ+yk6zuOYhEaEyvQn138rKvgC6rnOI
 iCUXEY2UuPJuHzi3ATngJUYhKC7NskwVbhGf1xMHMP1GqkjC3cRC/zIDqRMu9KwKOyaI
 fE1oZIsj7SCluiNS6B2RN0eYTrU0ctN4ITcvtJsbg9RPdNPIeWHgfgCZKpJt9aX8QJMZ
 k5d8DA9TXPtvd7uPMwY8KRgA5r/yzHpZQNLgS3AvgRcP9ZzZt76FTf2M7GbtkIRkjSqP
 ZZfVUzfMT0NGnI2xMpOSgBy/ApkdE8AMz7azsJORUv8bY5enoqKgIiVC5LSexG14HCao
 22dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463375; x=1787068175;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iB/qQSYRhbg3Mhm2Uf53Xe0wpCtWdBbA0N1MS7q6eYg=;
 b=mMxat4sscWevNUu8uLrqokQoXannmdXKiNOYKCvJg05oG8GX5QTvksAzZx3OY0/0Pb
 XXXs1agyDyLDYdx91dl43h4B77Tntx7bA5fYXHwfYGdJ+VRf+qDxyazxZ4OJy64j1Ih7
 TguMd3BqYfEBRf7oTHQZdYO20pgAR+k532pNXe5aQtLeYFwZBHunZ/hLjEj0FfkF1gKk
 Ir2B1XySUHpKrTKwBPKbeEO7X8hQduTRDAIyndAyxTj8F72w3FFDSzvT3Vi1mI1tSCwS
 QdAGCkJ2JTeZTRetEMW+C1cR4tOnQhfvZIyi0va7+OKySBnJILJri1/S8jqoJPI7OT2M
 UVyQ==
X-Gm-Message-State: AOJu0Yzu7bZTHyhl9/IcxYaL0rZKQVDw+tmcRIi4j8QwuS1gr0m0bWUZ
 rOlXzz+y9dTTbb4WSlxdJ9ucnAmlK8vz4yQN9qQ4c+wKpL95MCvzls9TMkzX6Fz15FkSSGOzObh
 qi1FeYtdqlR3e//EHCTxxduGP8ufPkOTL944gClaD2KijPx1E8+t5J/6f69mnrm24XA==
X-Gm-Gg: AR+sD13oWQ53ReINADhPKAKkSWI+qnQxyyk1m9rLwVOXK2SJbgGHbf/xo0ytVhvRsdP
 HMv4uZkBXEDmqwXCZBeCjObTzJydgscQmXtVvk5Gs0p0+Mg9aMaQvf7+H1bYQOb10n36IGdXKlq
 DkqTJ5QPXGGOQI0fQkeve8c9e1HDfhRfbIeFxiikaItBYJmainBnabMnAS/da5pShWR82UomAyT
 ORQtaT8sAd0SeHyrLETa7B2lY84FIghp6GTkfLNu9iV3B7x1QM7G3rZeE+xTD0xXgC8XQxqaOQV
 d782qoz+07/o3Z+4vQrg4fY7LAHMrRxEK3IepO3B7FvwP2IEvNX1/dKtkA+kTOfQMD+SWU33btY
 7Uo5FZ82oQlOLebIiO2Nc5VD0Sdv2vK2vnVocr78jow==
X-Received: by 2002:a05:622a:248c:b0:527:7813:a439 with SMTP id
 d75a77b69052e-52d602097camr14806861cf.27.1786463374440; 
 Tue, 11 Aug 2026 08:49:34 -0700 (PDT)
X-Received: by 2002:a05:622a:248c:b0:527:7813:a439 with SMTP id
 d75a77b69052e-52d602097camr14806211cf.27.1786463373932; 
 Tue, 11 Aug 2026 08:49:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aa96fb5sm2110825e9.3.2026.08.11.08.49.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:49:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 0/7] hw/nmi: Disconnect of vCPU and disentangle Monitor code
Date: Tue, 11 Aug 2026 17:49:23 +0200
Message-ID: <20260811154930.13915-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UGdcV2kKRHoWMZgbLjwl3QKlFG3KsEh6
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7b4490 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=C5rFN5O0vr7X1WtnuFMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: UGdcV2kKRHoWMZgbLjwl3QKlFG3KsEh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX7TFKGZVA203E
 mbOHVAxisIu3iWiu3i2tL+e6RM03egzx5C11WqWMgSvBJCEjxbxvg4KNH919MRYf4zgHDPZzPG4
 uGQxQXN8A7un5D6leIBEwDRtBFDx3KVmoxX7IzMF5TrWo+JT9cCOChxdq/u8atpjQgCJRETWhuN
 EFqxbcWCWUvekqIIzVtI/Iz1MAtkNVxbquMhAF54qTjYboCS9VqI/ks3QHsQWvkWfjhSVw8V5QD
 lSjzQtvadXXfYV/DeObrzMIYOsLtmZTSIINL8tPsSE0k4IDFZzEd6/MkmVPnlbBOs7+XUZIo5j5
 /eHFxZz4yAX2lmUYopIXm53lg++4YO7VUQD/7zLmtXC0VgM7ScI8ab+A1oRl4H8Msvdd1LuiHRI
 kH04KzF5UX4YYSCxqO83uLf+4DtZqxslHwmmbtQ621NC0ndDwUNsRFWvHf0S2EkNAg9eSmAfeAS
 rwWVkqukgBepcf7PA0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX54d7jSxBswSh
 0jctqiQVkBT57ppdr6wh3m5SkyAXb8I+YWx4o6LvhebY+zL/x1Yac9shsvGAMIQwNYFt6KcvF2e
 bQ4asWcJd+4CzdPkxTRNkyBXmjmj/2U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110132
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

Since v3:
- Rename trigger -> inject (API entry point)
- Rename deliver -> raise (machine-specific handler)
- Do not mention 'cpu' in HMP doc

Cover:

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
  hw/s390x/virtio-ccw: Always inject NMI to first CPU
  hw/nmi: Remove @cpu_index argument from
    NMIClass::nmi_monitor_handler()
  hw/nmi: Remove @cpu_index argument from nmi_inject()
  hw/nmi: Rename nmi_monitor_handler() -> raise_nmi()
  hw/nmi: Remove unused @errp argument from raise_nmi()
  hw/nmi: Raise NMI line only once

 qapi/machine.json          |  7 +++---
 qapi/run-state.json        |  6 +++--
 include/hw/core/nmi.h      | 34 +++++++++++++++++++++++++--
 hw/core/nmi.c              | 48 +++++++++++---------------------------
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
 hmp-commands.hx            |  7 +++---
 16 files changed, 78 insertions(+), 67 deletions(-)

-- 
2.53.0


