Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631E5C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6RI-0007QS-7b; Wed, 29 Jul 2026 11:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6RG-0007Q2-7H
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:43:22 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6RD-0002PB-1r
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:43:21 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso5946085e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339797; x=1785944597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F4nZHdINTnucSq7Z8OlpkEOEdhRIl21v1VFou+xFxuI=;
 b=dokUZBQWu0Z8Fz/5RJdAs5E3wgWwINKg4hlqjQaCETMV95o+2lftWFfI7fwIvKJe4O
 PUBnW4lceFrkXyI06jTQG0SAGI607hwKkJ9sDtqHQsZop3/11tU1+Y8BW/lcnn0MgfLP
 Ab0NksTe8PkPVGZRD+3S1nPUDk80CFevblaZ9YaxAiiYlqcC/K8gFNg5pOVA2F8Mbd4q
 KyBi6E3C0mGeE55plcplIkPXOS2swQszRzobF9Fr8rudXVoITN42RhtwUVIuCoHfNBlw
 Xk4tOsW94XnLjcHoF3Bmt3ebT0zQA+b4sk+rswUvEpaNYVxzZAe5gAizaiEhqyfxePsR
 AS1g==
X-Gm-Message-State: AOJu0YzdqVAvLaAJiXt3j2Q2Xt/rI/vePXz3XJ3E7TN2wCR8HHfgbRCQ
 MzMpn827F+/I7Wl88og2OE0CGtmyB7VO1HieQtS3PB0iUy9M3WCzQn/RxjlepNHV
X-Gm-Gg: AR+sD12ZQJlCSf0BmSHbPTD0YkmDRkU7ZGsQPChQsoPTzjMCF4sNdKHFJfhvieauKi8
 pSPOOBk/14YrEwnz5x9LO6ApzK8op2oAGNEd+VrdrxzVE6QG5gjc/WPS5iBOYYcR4VCjEnGN2Pu
 Y+b9YEmQthRiwOnyGMSWR2HV/OegD83ITVWebU05w8LLDworqkxneF2wcnNWKkWZumdST2RmNad
 xCJWYeQVEHyK0CAjuBwXhcuPmrBSo9b7Ky85MAhSNU51Km4pjT9f9E2C6kGp8KD10WHYKK4Cqci
 MHD1YKWfmfph+Axqp3NIJCAIw1i7geDaMWb4DtlVR0m1MKzeATHXop1OC/RBSv+BoJHhl4R7Sdo
 r/8m0e0O5CnZRzzOlWD5oQ17PX5tZc1EnGImMTYRo6ic815rOPUyeU5lN4hAB842zbHC++LjRRI
 8NdHM8vE5DKsC3v9neZMpQSi4WBYR8c1jio0VRzu9iiUKgyiBIxbr96n/Gm3T29OnPfw06Pzrbp
 +rixSVF/J0mFs8VBtgl4qa2G+OC9YZmg+tmIJKey2hE4Fk=
X-Received: by 2002:a05:600c:3144:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-496c642d855mr73577715e9.1.1785339797269; 
 Wed, 29 Jul 2026 08:43:17 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd6e179sm72738865e9.9.2026.07.29.08.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:43:16 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:54 +0200
Subject: [PATCH 18/25] tests/functional: add a pure-Python device-locator
 resolver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-18-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337965; l=25422;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=7fD1yFWWWP8lDPwkjc60ENxjrgiLOYsAzw1MFakslyM=;
 b=q5unU7AAbpz66K2eRgianaM1zbWMPQwBsy4NI6bWcaS8oSvVn06Kmar5ITnm7QErfhGd/pW8U
 S79SONxm+w2CPSYl1RoHT2uX9l0Rc0B6teY9JpLc2j+ix/5NzKt2+Vz
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f49.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add DeviceLocator, a helper that addresses a device by its position on
the bus -- bus, address, type or index -- rather than by a QOM path. A
QOM path locates a device under the object that owns it, by enumeration
order, and so says nothing about where the device actually sits in the
bus topology. From a QOM anchor DeviceLocator instead walks the bus and
device hierarchy, alternating bus and device hops, to reach the target.

It relies only on standard QOM queries over QMP, needing no custom
commands or changes to QEMU.

QEMU still supports Python 3.9, but 3.9 reached end of life on
2025-10-31. This new, optional helper therefore adopts the clearer
type-hint syntax introduced in Python 3.10 (such as "X | Y" unions)
rather than the more verbose 3.9 equivalents. Its import is guarded so
the module still loads on 3.9; tests that use the resolver are skipped
there.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/qemu_test/locator.py | 578 ++++++++++++++++++++++++++++++++++
 1 file changed, 578 insertions(+)

diff --git a/tests/functional/qemu_test/locator.py b/tests/functional/qemu_test/locator.py
new file mode 100644
index 0000000000..a735c0710d
--- /dev/null
+++ b/tests/functional/qemu_test/locator.py
@@ -0,0 +1,578 @@
+# Device locator: resolve a device from a QOM anchor plus a typed
+# bus/device traversal, entirely over QMP.
+#
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import re
+import sys
+from collections.abc import Callable, Iterable
+from typing import Any, NamedTuple
+
+from qemu.qmp import ExecuteError
+
+
+# The type hints below use PEP 604 unions ("X | None") and PEP 585 built-in
+# generics ("list[...]"), which require Python 3.10+.
+# Fail with a clear message rather than a cryptic TypeError from the
+# annotations when run on an older interpreter.
+if sys.version_info < (3, 10):
+    version = ".".join(map(str, sys.version_info[:3]))
+    raise RuntimeError(
+        f"qemu_test.locator requires Python 3.10+; "
+        f"interpreter is Python {version}")
+
+
+BusDomain = tuple[str, str | None]
+"""A bus domain: ``(bus_typename, address_property_or_None)``."""
+
+
+class LocatorError(Exception):
+    """Raised when a locator cannot be resolved."""
+
+
+class DeviceSelectors(NamedTuple):
+    """Parsed selectors of a single device hop ("type@addr#index=id")."""
+    typename: str | None = None
+    """QOM type name."""
+    addr: int | None = None
+    """Bus address."""
+    on_bus_index: int | None = None
+    """On-bus (BusChild) index."""
+    ident: str | None = None
+    """Device id."""
+
+
+class DeviceLocator:
+    """
+    Find a device by traversing the bus and device hierarchy, addressing
+    it by position -- bus, address, type or index -- rather than by a
+    fragile canonical QOM path.
+
+    A locator string is a QOM anchor followed by a typed traversal that
+    alternates bus and device hops. Resolution runs against a live guest
+    over QMP, using only qom-list / qom-get / qom-list-types, so it works
+    against any QMP-capable QEMU without extra commands.
+
+    Grammar::
+
+        <anchor> [ '::' <hop> ( '~' <hop> )* ]
+
+    '::' leaves the QOM anchor and enters typed traversal; '~' crosses
+    the device<->bus boundary (either direction). Because bus<->bus is
+    impossible and the only object->object hop is the leading controller
+    (which follows '::' directly, never '~'), every '~' marks a
+    device<->bus crossing.
+
+    <anchor> is a QOM path: absolute ("/machine/soc"), partial ("soc",
+    matched as a component suffix), or empty for /machine.
+
+    Hops alternate between object context and bus context. Starting from the
+    anchor a hop is one of:
+
+    object hop      <qom-type> [ '[' index ']' ]
+        Descend to a direct (child<>) child whose concrete QOM type is-a
+        <qom-type> (e.g. "aspeed.i2c-ast2600"), picked by [index] when
+        several match. This names a controller by its real QOM type, with
+        no keyword table involved.
+
+    bus hop         <bus> [ '[' channel ']' ]
+        Select a bus owned by the current object. <bus> is a domain keyword
+        ("i2c", "spi") or a bus QOM type ("i2c-bus", "SSI"); [channel] picks
+        among the buses of that type, ordered by their trailing number. Only
+        bus domains are tabulated, and solely to map a keyword to its bus
+        type and to the device address property used by '@' below.
+
+    device hop      [type] [ '@' addr ] [ '#' index ] [ '=' id ]
+        Match a device on the current bus by QOM type, bus address (the I2C
+        address or SPI chip-select), on-bus (BusChild) index and/or id.
+
+    Example: "/machine/soc::aspeed.i2c-ast2600[0]~i2c[9]~tmp75@0x4b".
+    """
+
+    DEFAULT_BUS_DOMAINS: dict[str, BusDomain] = {
+        "i2c": ("i2c-bus", "address"),
+        "spi": ("SSI", "cs"),
+    }
+    """Keyword -> ``(bus_typename, address_property_or_None)``."""
+
+    BUS_BASE = "bus"
+    """The QOM base type every bus derives from."""
+
+    def __init__(
+        self,
+        qmp: Callable[..., Any],
+        bus_domains: Iterable[tuple[str, str, str | None]] | None = None,
+    ) -> None:
+        """
+        :param qmp: a callable ``qmp(command, **args)`` returning the QMP
+                    payload and raising on error -- e.g. ``QEMUMachine.cmd``.
+        :param bus_domains: optional iterable of ``(keyword, bus_typename,
+                        address_property)`` tuples registered up front; the
+                        "i2c" and "spi" bus domains are always registered.
+        """
+        self._qmp = qmp
+        self._bus_domains: dict[str, BusDomain] = dict(
+            self.DEFAULT_BUS_DOMAINS)
+        self._qom_subtypes_cache: dict[str, set[str]] = {}
+        for keyword, bus_typename, address_property in bus_domains or ():
+            self.register_bus_domain(keyword, bus_typename, address_property)
+
+    def register_bus_domain(self, keyword: str, bus_typename: str,
+                        address_property: str | None = None) -> None:
+        """
+        Register an additional bus domain.
+
+        :param keyword: domain keyword used in a bus hop (e.g. "i2c").
+        :param bus_typename: the QOM bus type backing the domain.
+        :param address_property: device property holding the bus address, or
+                                 None when the domain has no address selector.
+        """
+        self._bus_domains[keyword] = (bus_typename, address_property)
+
+    # -- QOM access over QMP ---------------------------------------------
+
+    def _qom_list(self, path: str) -> list[dict[str, Any]]:
+        """
+        List the QOM child/link properties of an object.
+
+        :param path: canonical QOM path to enumerate.
+        :return: the ``qom-list`` payload, one dict per property.
+        """
+        return self._qmp("qom-list", path=path)
+
+    def _qom_get(self, path: str, prop: str) -> Any:
+        """
+        Read one QOM property.
+
+        :param path: canonical QOM path of the object.
+        :param prop: property name to read.
+        :return: the property value.
+        """
+        return self._qmp("qom-get", path=path, property=prop)
+
+    def _qom_type_of(self, path: str) -> str:
+        """
+        Return an object's concrete QOM type name.
+
+        :param path: canonical QOM path of the object.
+        :return: the QOM type name.
+        """
+        return self._qom_get(path, "type")
+
+    def _qom_subtypes(self, typename: str) -> set[str]:
+        """
+        Return the set of every type that is-a @typename (itself included).
+
+        :param typename: the base or interface type name.
+        :return: the implementing type names, cached per base.
+        """
+        cached = self._qom_subtypes_cache.get(typename)
+        if cached is None:
+            listed = self._qmp("qom-list-types", implements=typename,
+                               abstract=True)
+            cached = {entry["name"] for entry in listed}
+            cached.add(typename)
+            self._qom_subtypes_cache[typename] = cached
+        return cached
+
+    def _qom_is_a(self, concrete: str, base: str) -> bool:
+        """
+        Report whether one QOM type is-a another.
+
+        :param concrete: a concrete QOM type name.
+        :param base: a base or interface type name.
+        :return: True if @concrete is or derives from @base.
+        """
+        return concrete == base or concrete in self._qom_subtypes(base)
+
+    # -- QOM tree helpers ------------------------------------------------
+
+    @staticmethod
+    def _inner_type(proptype: str) -> tuple[str | None, str | None]:
+        """
+        Split a "child<X>"/"link<X>" property type.
+
+        :param proptype: a QOM property type string.
+        :return: ``(kind, inner)`` with kind "child" or "link", or
+                 ``(None, None)`` for any other property.
+        """
+        match = re.match(r"(child|link)<(.+)>$", proptype)
+        if match:
+            return match.group(1), match.group(2)
+        return None, None
+
+    @staticmethod
+    def _order_key(name: str) -> tuple[int, str]:
+        """
+        Ordering key for a QOM path component: the last run of decimal digits
+        in the name ("aspeed.i2c.10" -> 10), or -1 when it carries no number.
+
+        :param name: a canonical path component.
+        :return: ``(index, name)``, with the name as tie-breaker.
+        """
+        runs = re.findall(r"\d+", name)
+        return (int(runs[-1]) if runs else -1, name)
+
+    def _canonical_children(self, path: str) -> list[tuple[str, str, str]]:
+        """
+        Enumerate the canonical (child<...>) children of an object.
+
+        :param path: canonical QOM path to enumerate.
+        :return: ``(name, property_type, child_path)`` per canonical child.
+        """
+        children: list[tuple[str, str, str]] = []
+        for prop in self._qom_list(path):
+            kind, inner = self._inner_type(prop["type"])
+            if kind == "child" and inner is not None:
+                children.append((prop["name"], inner,
+                                 path + "/" + prop["name"]))
+        return children
+
+    def _collect_buses(self, root: str,
+                       bus_typename: str) -> list[tuple[str, str]]:
+        """
+        Collect the domain buses reachable under @root, pruned at each found
+        bus so buses nested behind a downstream device (e.g. an I2C mux) are
+        not gathered.
+
+        :param root: QOM path to search from.
+        :param bus_typename: the domain's QOM bus type.
+        :return: ``(name, path)`` per bus, sorted by component order.
+        """
+        found: list[tuple[str, str]] = []
+        for name, concrete, child_path in self._canonical_children(root):
+            if self._qom_is_a(concrete, bus_typename):
+                found.append((name, child_path))
+            else:
+                found.extend(self._collect_buses(child_path, bus_typename))
+        found.sort(key=lambda item: self._order_key(item[0]))
+        return found
+
+    def _bus_children(self, bus: str) -> list[tuple[int, str]]:
+        """
+        Enumerate the devices attached to a bus.
+
+        :param bus: canonical QOM path of the bus.
+        :return: ``(on_bus_index, device_path)`` per attached device, sorted
+                 by index.
+        """
+        kids: list[tuple[int, str]] = []
+        for prop in self._qom_list(bus):
+            match = re.match(r"child\[(\d+)\]$", prop["name"])
+            kind, _ = self._inner_type(prop["type"])
+            if match and kind == "link":
+                kids.append((int(match.group(1)),
+                             self._qom_get(bus, prop["name"])))
+        kids.sort(key=lambda item: item[0])
+        return kids
+
+    # -- anchor / plain-path resolution ---------------------------------
+
+    def _exists(self, path: str) -> bool:
+        """
+        Report whether a QOM path resolves to an existing object.
+
+        :param path: an absolute QOM path.
+        :return: True if the object exists.
+        """
+        try:
+            self._qom_list(path)
+            return True
+        except ExecuteError:
+            return False
+
+    def _all_paths(self, root: str = "/machine") -> list[str]:
+        """
+        Collect every canonical object path under @root, @root included.
+
+        :param root: QOM path to search from.
+        :return: the list of canonical paths.
+        """
+        paths: list[str] = [root]
+        for _name, _concrete, child_path in self._canonical_children(root):
+            paths.extend(self._all_paths(child_path))
+        return paths
+
+    def _resolve_anchor(self, anchor: str) -> str:
+        """
+        Resolve a QOM anchor: empty -> /machine, an absolute path used
+        verbatim, otherwise a component-suffix search over the whole tree.
+
+        :param anchor: the anchor part of a locator.
+        :return: the resolved canonical QOM path.
+        :raises LocatorError: if the anchor is missing or ambiguous.
+        """
+        if anchor == "":
+            return "/machine"
+        if anchor.startswith("/"):
+            if not self._exists(anchor):
+                raise LocatorError(f"anchor '{anchor}' not found")
+            return anchor
+
+        wanted = anchor.split("/")
+        matches = [path for path in self._all_paths()
+                   if path.split("/")[-len(wanted):] == wanted]
+        if not matches:
+            raise LocatorError(f"anchor '{anchor}' not found")
+        if len(matches) > 1:
+            raise LocatorError(f"anchor '{anchor}' is ambiguous "
+                               f"({len(matches)} found)")
+        return matches[0]
+
+    # -- hop parsing ----------------------------------------------------
+
+    @staticmethod
+    def _parse_indexed(token: str) -> tuple[str, int | None]:
+        """
+        Parse an object or bus hop ("name" or "name[index]").
+
+        :param token: the hop token.
+        :return: ``(name, index_or_None)``.
+        :raises LocatorError: on a malformed hop.
+        """
+        match = re.match(r"([^\[]+)(?:\[(\d+)\])?$", token)
+        if not match:
+            raise LocatorError(f"malformed hop '{token}'")
+        index = int(match.group(2)) if match.group(2) is not None else None
+        return match.group(1), index
+
+    @staticmethod
+    def _parse_device(token: str) -> DeviceSelectors:
+        """
+        Parse a device hop into its selectors.
+
+        :param token: the device-hop token ("type@addr#index=id").
+        :return: the parsed selectors.
+        :raises LocatorError: on a malformed or empty hop.
+        """
+        typename: str | None = None
+        addr: int | None = None
+        index: int | None = None
+        ident: str | None = None
+        pos = 0
+        length = len(token)
+        # A leading bare run (no sigil) is the QOM type selector.
+        if pos < length and token[pos] not in "@#=":
+            start = pos
+            while pos < length and token[pos] not in "@#=":
+                pos += 1
+            typename = token[start:pos]
+        seen = typename is not None
+        while pos < length:
+            sig = token[pos]
+            pos += 1
+            start = pos
+            while pos < length and token[pos] not in "@#=":
+                pos += 1
+            value = token[start:pos]
+            if sig == "@":
+                try:
+                    addr = int(value, 0)
+                except ValueError:
+                    raise LocatorError(f"malformed address '@{value}'")
+            elif sig == "#":
+                try:
+                    index = int(value, 10)
+                except ValueError:
+                    raise LocatorError(f"malformed on-bus index '#{value}'")
+            elif sig == "=":
+                ident = value
+            seen = True
+        if not seen:
+            raise LocatorError("empty device hop")
+        return DeviceSelectors(typename, addr, index, ident)
+
+    def _is_bus_token(self, token: str) -> bool:
+        """
+        Report whether a hop names a bus (a domain keyword or a bus QOM type)
+        rather than an intermediate object.
+
+        :param token: an object-or-bus hop token.
+        :return: True for a bus hop.
+        """
+        name = token.split("[", 1)[0]
+        return name in self._bus_domains or self._qom_is_a(name, self.BUS_BASE)
+
+    @staticmethod
+    def _pick(items: list[str], index: int | None, what: str) -> str:
+        """
+        Select one entry from an ordered match list.
+
+        :param items: the ordered candidate paths.
+        :param index: the requested index, or None to require a single match.
+        :param what: a description used in error messages.
+        :return: the selected path.
+        :raises LocatorError: if nothing matches, the match is ambiguous, or
+                              the index is out of range.
+        """
+        if index is None:
+            if not items:
+                raise LocatorError(f"no {what} found")
+            if len(items) > 1:
+                raise LocatorError(f"{what} is ambiguous "
+                                   f"({len(items)} found); add an index")
+            return items[0]
+        if index >= len(items):
+            raise LocatorError(f"{what} index {index} out of range "
+                               f"({len(items)} found)")
+        return items[index]
+
+    # -- resolution -----------------------------------------------------
+
+    def resolve(self, locator: str, typename: str | None = None) -> str:
+        """
+        Resolve a locator to a canonical QOM path (usable with qom-get).
+
+        :param locator: the locator string (see the class grammar).
+        :param typename: if set, the leaf is verified to be-a this QOM type.
+        :return: the resolved canonical QOM path.
+        :raises LocatorError: if the locator does not resolve to exactly one
+                              object (not found, ambiguous, unknown bus or
+                              malformed), or the leaf fails the type check.
+        """
+        sep = locator.find("::")
+        if sep < 0:
+            return self._apply_type(self._resolve_anchor(locator), typename)
+
+        cur = self._resolve_anchor(locator[:sep])
+        bus: str | None = None
+        bus_concrete: str | None = None
+        dom: BusDomain | None = None
+
+        for token in locator[sep + 2:].split("~"):
+            if token == "":
+                raise LocatorError(f"empty hop in locator {locator!r}")
+            if bus is not None:
+                cur = self._hop_device(bus, bus_concrete, dom, token)
+                bus = None
+            elif self._is_bus_token(token):
+                bus, bus_concrete, dom = self._hop_bus(cur, token)
+                cur = bus
+            else:
+                cur = self._hop_object(cur, token)
+
+        return self._apply_type(cur, typename)
+
+    def _hop_object(self, cur: str, token: str) -> str:
+        """
+        Apply an object hop, descending to a direct child by QOM type.
+
+        :param cur: current QOM path to search under.
+        :param token: the object-hop token ("type" or "type[index]").
+        :return: the matched child's canonical QOM path.
+        :raises LocatorError: if zero, several (without an index) or an
+                              out-of-range child matches.
+        """
+        name, index = self._parse_indexed(token)
+        matches: list[tuple[str, str]] = []
+        for child_name, _inner, child_path in self._canonical_children(cur):
+            if self._qom_is_a(self._qom_type_of(child_path), name):
+                matches.append((child_name, child_path))
+        matches.sort(key=lambda item: self._order_key(item[0]))
+        return self._pick([path for _name, path in matches], index,
+                          f"object '{name}'")
+
+    def _hop_bus(self, cur: str,
+                 token: str) -> tuple[str, str, BusDomain | None]:
+        """
+        Apply a bus hop, selecting a bus owned by the current object.
+
+        :param cur: current QOM path to search under.
+        :param token: the bus-hop token ("bus" or "bus[channel]"), where
+                      "bus" is a domain keyword or a bus QOM type.
+        :return: ``(bus_path, bus_concrete, domain)``; @domain is the mapped
+                 domain for a keyword, or None for a raw bus type (its address
+                 property is then inferred at the device hop).
+        :raises LocatorError: on an unknown bus, or a missing, ambiguous or
+                              out-of-range bus.
+        """
+        name, index = self._parse_indexed(token)
+        if name in self._bus_domains:
+            dom: BusDomain | None = self._bus_domains[name]
+            bus_typename = dom[0]
+        elif self._qom_is_a(name, self.BUS_BASE):
+            dom = None
+            bus_typename = name
+        else:
+            raise LocatorError(f"'{name}' is not a bus domain or bus type")
+
+        buses = self._collect_buses(cur, bus_typename)
+        bus_path = self._pick([path for _name, path in buses], index,
+                              f"bus '{name}'")
+        return bus_path, self._qom_type_of(bus_path), dom
+
+    def _hop_device(self, bus: str, bus_concrete: str | None,
+                    dom: BusDomain | None, token: str) -> str:
+        """
+        Apply a device hop, matching one device on the current bus.
+
+        :param bus: canonical QOM path of the current bus.
+        :param bus_concrete: the bus's concrete QOM type, for domain inference.
+        :param dom: the active domain, or None to infer it from the bus.
+        :param token: the device-hop token.
+        :return: the matched device's canonical QOM path.
+        :raises LocatorError: if zero or several devices match.
+        """
+        sel = self._parse_device(token)
+
+        if dom is None and bus_concrete is not None:
+            for spec in self._bus_domains.values():
+                if self._qom_is_a(bus_concrete, spec[0]):
+                    dom = spec
+                    break
+
+        matches: list[str] = []
+        for index, dev_path in self._bus_children(bus):
+            if self._device_matches(dev_path, index, sel, dom):
+                matches.append(dev_path)
+
+        if not matches:
+            raise LocatorError(f"no device matches '{token}'")
+        if len(matches) > 1:
+            raise LocatorError(f"device hop '{token}' is ambiguous "
+                               f"({len(matches)} matches)")
+        return matches[0]
+
+    def _device_matches(self, dev_path: str, index: int,
+                        sel: DeviceSelectors, dom: BusDomain | None) -> bool:
+        """
+        Test one device against a hop's selectors.
+
+        :param dev_path: canonical QOM path of the candidate device.
+        :param index: the device's on-bus (BusChild) index.
+        :param sel: the parsed selectors to match.
+        :param dom: the active domain (provides the address property), or None.
+        :return: True if the device satisfies every selector.
+        """
+        if sel.typename is not None:
+            if not self._qom_is_a(self._qom_type_of(dev_path), sel.typename):
+                return False
+        if sel.addr is not None:
+            address_property = dom[1] if dom else None
+            if address_property is None:
+                return False
+            if self._qom_get(dev_path, address_property) != sel.addr:
+                return False
+        if sel.on_bus_index is not None and index != sel.on_bus_index:
+            return False
+        # '=id' matches the object's canonical-path leaf, which for a device
+        # created with '-device ...,id=X' is X.
+        if sel.ident is not None and dev_path.rsplit("/", 1)[-1] != sel.ident:
+            return False
+        return True
+
+    def _apply_type(self, path: str, typename: str | None) -> str:
+        """
+        Verify a resolved object's type, if requested.
+
+        :param path: canonical QOM path of the resolved object.
+        :param typename: expected QOM type, or None to skip the check.
+        :return: @path unchanged.
+        :raises LocatorError: if the object is not of @typename.
+        """
+        if typename is not None and not self._qom_is_a(self._qom_type_of(path),
+                                                   typename):
+            raise LocatorError(f"resolved object is not of type '{typename}'")
+        return path

-- 
2.50.1


