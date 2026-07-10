Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27E8C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiH0k-0001sI-Mb; Fri, 10 Jul 2026 15:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiH0X-0001oL-PJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:35:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiH0R-0007Wi-HS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:35:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH41X71325797
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4jCmDTAF5qDm+F7nflk8HKT6yzWm4iLV6yXFGd/oUbE=; b=J3gCeRCkGoVDF81x
 b3ncrS5QzMUP1VYkdxtocVSGEhxaUPUKfAP4JAAqcVdYnfD4++be1j0SCRjtk0DV
 PdXummVvhNLQv6YUppXvBA6dT7B1VwQRtzSp+1eBQk9/oVGxrLLDm61smsvPBoL7
 ExMZT11HiCLpbzLls/ABazL4so8HgY+2/Z1ycikE57GmoP0c4v8aJhLgzkWssVEX
 kaSjgiODq4Llf54rqo1/hvzXRpUmFvftLixgjejoOH1LxxqJqyWXO/lX2H/oBB7M
 poU9EIQAaT6AO5PQSXSN0DT4nNzboVPnLZTHv3oxOHd2SYYzyK6f9CAWXDwAiTPX
 BEhi+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339rx7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:35:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37fca5f21b1so1982215a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783712124; x=1784316924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4jCmDTAF5qDm+F7nflk8HKT6yzWm4iLV6yXFGd/oUbE=;
 b=fIo/zPb9+T4QOyrFVth4IM6CoCW8cR17whSWBK5bMF1BQ+I0TO20T3ZNHkyu3+Hsuz
 uXhsaeUUZHrlg2WVR6CO9SBejNJGTLt6jIRW1g0Bdvmi9t4YqA9iBfZA9oOoVJ7WQpZn
 BfZhh5vUgcUcwKg2/1aqjhZjLfp7IsOXcmZ6SUZO3Dc5koaKff1q3tjmvprakLWgZmCi
 xF6jWXHOYpH8ylxmSbQungF40WGXZtdPpdET9OJiQIe7XX7vDKf6SFSODBH3wyIou9w6
 4Q/tVEPNZyFtnpyNzAkyLgJ/Oh64EanayIhDrWxPeAA5OjRemlJRrKK+lrZmR+aVPvbP
 BnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783712124; x=1784316924;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4jCmDTAF5qDm+F7nflk8HKT6yzWm4iLV6yXFGd/oUbE=;
 b=eClJixqZ+GthnChPdfvEu8Gi25W5wH9pzpchOZA+hBdp1GIke9OT9pjtkjWOmjePzi
 nnB2KktQP3DAr5pn+VUFZom53OF60/6f3+mJOJ7qpxVNVsec3HSAWG4Wl2eXnDb86RnR
 XSVlxW+zxP4oTUS85o582K78C59YK6ZTsbQ61Z4U7CEtqWbb+gnXtpbWTwGSO7ufcexx
 uXKiJSqcH0i/MkF6ROI+xSNzRmCalFSfUriohtlXgUdzCeaYM+W6kwgpTmagjWIyh5eM
 pbcH5N9lpXpCVGgEREgLjmeMxW9wDW7SXNCjjW4AYymCYU/XXPideFe3dT7mSX+IsOFp
 ufNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqwx8wnzs+vCVtC8fqUpxwekn+dBiHAs29+14ZHCXepVE8UDq1FBwq7tsGtYYwKqBFWdI6/7Dk/XLEn@nongnu.org
X-Gm-Message-State: AOJu0Yz3PN4/ihPGqHrrmxKC26P2k2mTdz0tmNANGRXzoyh8mSIEJWxO
 Duu+bi6N8q0SarwdffBXY4HkdpCx4/kvOq7iNdClL3NryzjAHUf15a6WY17mLumIM8lmq48lxu3
 Dh37ZIPdr9mIghEPnxa/u5z7wmL2k+5xVI1ucMtfPXy6V+1duhQ4qG6f01A==
X-Gm-Gg: AfdE7clZbeLpzPl4UkBFW/3mDdsYWgJgKNSPVoFveDSBXrphdjPRFeyHH17TMdlnED3
 CRj5Ga9odasmq/ZGEyefU6x0/QJvSv86e8M/fgYqYZkh5LAfkF3YYG7lpR3Ey50HZjEW1e9/vqB
 uCwgAy34uxt/Vs0JYVC14f0HUID6aGxDmAF83U5RHHOfeDwqJsrLa3sYo3gSiEh4u19X4aEYJSe
 Klx+ZeaZL2OEFgJhfF3YLCMNtZgxpKogbyBI+0rgZ9lRVWmxfRMnknwad59moxzr6ZxGiPIkJdr
 ZmvSN/yJJDhJJJA+Jdf70GnduwzGPmBerw/2mWlUrcAuVssEyz1F/C1Jp4jBf7QIGWFd+s3WjVr
 7hU+eVVDigNaEIFreE2TTsidD63D+O1mZpMskVwI/2xlnMndRQQ3OWTgWrW5VsAoRiWoJEEzLqo
 igqpY=
X-Received: by 2002:a05:6a21:1404:b0:3b4:731e:6fad with SMTP id
 adf61e73a8af0-3c0f094035emr5553033637.16.1783712123963; 
 Fri, 10 Jul 2026 12:35:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:1404:b0:3b4:731e:6fad with SMTP id
 adf61e73a8af0-3c0f094035emr5553009637.16.1783712123470; 
 Fri, 10 Jul 2026 12:35:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117462f5c7sm47280180eec.0.2026.07.10.12.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 12:35:22 -0700 (PDT)
Message-ID: <b87bca1d-376a-4d29-9c11-9d082962dd29@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fixes for unaligned scalar accesses
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Alessandro Di Federico <ale@rev.ng>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5NiBTYWx0ZWRfXxAB7Gw0J3PUs
 5sljH0DL4Ap0QGn/4JosMxG6bXpiWy85kKh62Jz8UIqSQvpJ3z/LDNTIEFiAHJs1b8TTeDwwaPO
 h4MbUpN10q5OCw7L9FjBPDWltPcfIfU=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a51497c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AgWKj-9Duvrl2_h3L6cA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: BNP_Au-giS1eM_8ndAMkVxLh1AD5Q1GF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5NiBTYWx0ZWRfX1ADV+3Uj2BVR
 nDEbJZFfTMVXgI0c5JFCdXlwQZD5JEcVaIsZ5i1lr7PdVEoWdPApWN/ajWCu4AqkHiIJ0hXawyB
 sB/R2xv+OQ4plfdYqXV3dKfjmVPivnuXgioBywHVTzSNFQP07JipIyUdqR8UVH9Q0BZyHFasRHT
 /Z5XNJzgHz0/IEWciYWWU4uZ4mxUjUFOyAelhkYT5xJTbQg91YJkymDwE17coSUsLirKuI2v+w1
 Y8EWBQZTRjiPbJBq6W/RY0mm34gk12RBlrAfD1YCv0HCR95KXpucBMRWPsc2WNPRvIwv1f0Q73V
 K7huWDivVeGxHO80I9JV31/G9F8/WwQTfmbuZE5OF7iu6SccnlOcIZsC9o9bT6yyIr+OgrdGjLe
 V2WN/R/fmHsatZbzuHcImcni63VUoWsm9ohFw8vfMI309ePiJQ9xdHTtKzjh5cF1Vc9o3AGK+8z
 i+cMzalBGL7TgQ32kfA==
X-Proofpoint-GUID: BNP_Au-giS1eM_8ndAMkVxLh1AD5Q1GF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100196
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/9/2026 4:34 PM, Brian Cain wrote:
> I took some "working" programs under userspace emulation into a linux
> instance running on a fork with comprehensive system mode support and
> discovered a compiler bug causing unaligned accesses.  This bug had
> gone undetected in userspace tests because they were not handled correctly
> by QEMU.
> 
> With these patches, unaligned accesses cause an exception that generates
> SIGBUS.
> 
> Brian Cain (4):
>   target/hexagon: raise SIGBUS on unaligned scalar loads
>   target/hexagon: raise SIGBUS on unaligned scalar stores
>   target/hexagon: raise SIGBUS on unaligned data access in sysemu
>   tests/tcg/hexagon: add unaligned scalar test
> 
>  linux-user/hexagon/cpu_loop.c               |   5 +
>  target/hexagon/cpu.c                        |  25 +++++
>  target/hexagon/genptr.c                     |  10 +-
>  target/hexagon/idef-parser/parser-helpers.c |   2 +-
>  target/hexagon/macros.h                     |  26 +++--
>  target/hexagon/op_helper.c                  |  13 ++-
>  target/hexagon/translate.c                  |   6 +-
>  tests/tcg/hexagon/Makefile.target           |   2 +
>  tests/tcg/hexagon/unaligned_data.c          | 118 ++++++++++++++++++++
>  9 files changed, 185 insertions(+), 22 deletions(-)
>  create mode 100644 tests/tcg/hexagon/unaligned_data.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


