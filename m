Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDC7CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxYz-0000qE-Nq; Tue, 23 Jun 2026 05:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wbxYy-0000pi-2l; Tue, 23 Jun 2026 05:37:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wbxYw-0008NK-EM; Tue, 23 Jun 2026 05:36:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6mTcT1148280; Tue, 23 Jun 2026 09:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bZyEr3
 dRmyRFceykhmN6ki9E1ucdnkdCyFDC9Wavq1U=; b=al3437wr7nW9feRHuk/UV4
 ZAeOnqgFVUiv4KcbtCGEr/tHbu1zNC3wQ7lKHnOS7jiq/Wp5j0KuWQzzPZmuq73b
 7tglT0y8XeJa6rz2L1xNw5Gc8Kdi4nnM8732JKt2oTmr515EfBHYoZD/NDVFh0oC
 InG6MVkpWNLmJFGIyKB7ESraJOMha4IfGgjzaXjSxwDMqDL8cx7fPbeqeouSfOOM
 t8rjSRK7uhXuywTexjksdxFgdGKa9HybhsltLdSj91wVp9l/2aXCaleKfiT+EsRQ
 Y3I+V4eVXama2SMbiMCyBgdkWQzwgqIp0Ym/Kdsji3Bm/5A68Y9uh6Vx3MWfXbHg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4dqwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 09:36:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N9YbI6024896;
 Tue, 23 Jun 2026 09:36:53 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg2b56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 09:36:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N9aqPk26280546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 09:36:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4E5258059;
 Tue, 23 Jun 2026 09:36:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BDEA58055;
 Tue, 23 Jun 2026 09:36:51 +0000 (GMT)
Received: from [9.123.1.190] (unknown [9.123.1.190])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 09:36:51 +0000 (GMT)
Message-ID: <22607674-c519-4384-a51e-51da9e7c9967@linux.ibm.com>
Date: Tue, 23 Jun 2026 15:06:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL SUBSYSTEM pseries 0/1] pseries: Update SLOF firmware image
 to release 20260618
Content-Language: en-GB
To: Thomas Huth <th.huth@posteo.eu>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20260618082623.345255-1-th.huth@posteo.eu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260618082623.345255-1-th.huth@posteo.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3NSBTYWx0ZWRfX6VCIDIBz2qRt
 xJyqiATxkVSfqxvoI1X1s1TP73Vu+jMv4ZYSp+WKLw7RCwBCs0Im8/OaPkMGtjd2wI5YOXOaWQx
 61850VaqmgIUYkJ2eXp8cB8izcr03f4=
X-Proofpoint-ORIG-GUID: nIHtqICTyDIDqTJYaoFPb50GYJdSO0HE
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a53b7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=p0WdMEafAAAA:8 a=Snqr5TmjRq-M2Cc8eBsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3NSBTYWx0ZWRfX8dNrbLoSwZZb
 85VHrkmsD0Jiucw5JBlm4E8JqM8d2qrq+auY55f3XKr0YVo7kMoZVZgPxkLkXx/xSHc6wU7Fi+z
 qZeu/R+oFDPfhG8gSY4SVcHXY+Y5ciltnh3u2MU4Wcn2sskTPufwAW1yC09rktjBBeJyKInCFft
 WUJo3FYPuo8Z8y8eUccdM8K2LeaL3jBqsxRbVGpQYaTSxeA78xTb+YdstS5/3yoj1jFFvoY8x/R
 h6I6MGzfkZQx3ZszCtSrUnu7ESnAIvDFzkY1LWEbQ0ORAv/Ank38rzOA9B6RlME/CJdLRa5k7E7
 l7NbDNYZIH30gjJTHKFW4kjB6T3Frx/Yt8bR/v4Jnj40VFqlAqPy6lo+eY/0w0EhRN6SCsO+8K4
 owGHes7G4uHQd0hiAnePViw1Fi7sAAjs0/u3tWBbI+A1ggQ1LTMa2fuQ+P4nl8ygDtHozkd/4xe
 FEOeDHCrCe4FzGW9SDw==
X-Proofpoint-GUID: 2I2MoZAbyEvkyeyh_S7hsy307Dml8Q2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230075
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Thomas,

On 18/06/26 1:56 pm, Thomas Huth wrote:
>   Hi Harsh, hi Nicholas!
> 
> The following changes since commit c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff:
> 
>    Merge tag 'firmware-20260617-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-06-17 10:17:29 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/huth/qemu.git tags/qemu-slof-20260618
> 
> for you to fetch changes up to 7abb51793e131ca374d4fb0c3f0d1878d9199069:
> 
>    pseries: Update SLOF firmware image to release 20260618 (2026-06-18 10:08:06 +0200)
> 
> Note: this is not for master, this is for pseries
> 
> ----------------------------------------------------------------
> - Fix parsing of ELF program headers
> 
> ----------------------------------------------------------------
> Thomas Huth (1):
>        pseries: Update SLOF firmware image to release 20260618
> 

Looks like updating VERSION file was missed before building the slof.bin
(as checked in gitlab repo). Also, I see below FW version (git-xxx)
during boot:

SLOF 
********************************************************************** 
  

QEMU Starting 
  

  Build Date = Jun 18 2026 08:06:19 
  

  FW Version = git-def1516ec9340518 
  

  Press "s" to enter Open Firmware.


Whereas, earlier, it used to appear like proper release timestamp:


SLOF **********************************************************************
QEMU Starting
  Build Date = Oct 26 2025 18:45:22
  FW Version = release 20251026
  Press "s" to enter Open Firmware.

Curious to know if it's only the VERSION update needed or something more 
(make args) ?

Thanks
Harsh
>   pc-bios/README   |   2 +-
>   pc-bios/slof.bin | Bin 994176 -> 997584 bytes
>   2 files changed, 1 insertion(+), 1 deletion(-)


